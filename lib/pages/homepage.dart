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
                    return MedCard(med: currentMed);
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
