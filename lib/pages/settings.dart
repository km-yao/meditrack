import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/providers/med_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  // TODO:
  // cambiare colori
  // cancellare ogni med

  void _pulisciDB() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Conferma"),
        content: Text("Sei sicuro di voler pulire il database? Questa operazione non è reversibile."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Annulla")),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ref.read(medProvider.notifier).deleteAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Database pulito"))
                );
              } catch (e) {
                throw Exception("SETTINGS_PAGE : Errore pulizia DB : $e");
              }

            }, 
            child: Text("Conferma")),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Center(
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: Column(
                spacing: 8,
                children: [

                  Text("Impostazioni", style: TextStyle(fontSize: 28)),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Text("Pulisci il database"),
                      Expanded(child: const SizedBox()),
                      TextButton(onPressed: _pulisciDB, child: Text("Pulisci"))
                    ],
                  )

                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
