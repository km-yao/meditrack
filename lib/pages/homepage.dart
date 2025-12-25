import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/models/med_card.dart';
import 'package:meditrack/models/med_response.dart';
import 'package:meditrack/pages/edit_med.dart';
import 'package:meditrack/pages/settings.dart';
import 'package:meditrack/providers/med_provider.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {

  late MedResponse medResponse;

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }


  void deleteMed(Med med) async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Elimina"),
        content: Text("Elimina il med ${med.nome}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Annulla")),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              try {

                // Elimina dal database
                await ref.read(medProvider.notifier).delete(med.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Med eliminato"))
                );

              } catch (e) {
                throw Exception("HOMEPAGE : Errore eliminazione med : $e");
              }

            }, 
            child: Text("Conferma")
          ),
        ],
      );
    });
  }

  void updateMed(Med med) async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Aggiorna"),
        content: Text("Aggiorna la data relativa a ${med.nome}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Annulla")),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              try {

                med.prelievo = DateTime.now();
                med.scadenza = med.prelievo.add(Duration(days: med.compresse));
                
                // Aggiorna il database
                await ref.read(medProvider.notifier).update(med);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Med aggiornato"))
                );

              } catch (e) {
                throw Exception("HOMEPAGE : Errore aggiornamento med : $e");
              }

            }, 
            child: Text("Conferma")
          ),
        ],
      );
    });
  }

  void medOptions(Med med) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.update),
              title: Text("Aggiorna"),
              onTap: () {
                Navigator.pop(context);
                updateMed(med);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Elimina"),
              onTap: () {
                Navigator.pop(context);
                deleteMed(med);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final medResponse = ref.watch(medProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "MediTrack",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () => _navigateToPage(context, Settings()),
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimary,),
          ),
        ],
      ),
      body: medResponse.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : medResponse.errorMsg.isNotEmpty
          ? Center(
              child: Text(
                medResponse.errorMsg,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              ),
            )
          : medResponse.list.isEmpty
          ? Center(
              child: Text(
                "Inserisci un nuovo Med",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 12,
                ),
                child: ListView.builder(
                  itemCount: medResponse.list.length,
                  itemBuilder: (context, index) {
                    Med currentMed = medResponse.list[index];
                    return MedCard(med: currentMed, onLongPress: medOptions,);
                  },
                ),
              ),
            ),
      // Raggiungere la pagina per inserire i med
      floatingActionButton: IconButton.filled(
        onPressed: () => _navigateToPage(context, EditMed()),
        icon: Icon(Icons.add),
        iconSize: 36,
      ),
    );
  }
}
