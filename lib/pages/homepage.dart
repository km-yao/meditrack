import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/models/med_response.dart';
import 'package:meditrack/pages/edit_med.dart';
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
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: null, icon: Icon(Icons.settings))],
      ),
      body: medResponse.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : medResponse.errorMsg.isNotEmpty
          ? Center(child: Text(medResponse.errorMsg, textAlign: TextAlign.center, style: TextStyle(fontSize: 36),))
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 40,
                ), 
                child: ListView.builder(
                  itemCount: medResponse.list.length,
                  itemBuilder: (context, index) {
                    Med currentMed = medResponse.list[index];
                    return Card(
                      margin: EdgeInsets.all(16),
                      elevation: 12,
                      child: Text(currentMed.nome),
                    );
                  }

                ),
              ),
            ),
      floatingActionButton: IconButton(onPressed: () =>  _navigateToPage(context, EditMed()), icon: Icon(Icons.add)),
    );
  }
}
