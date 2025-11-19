import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/models/med_response.dart';
import 'package:meditrack/providers/med_provider.dart';

class EditMed extends ConsumerStatefulWidget {
  const EditMed({super.key});

  @override
  ConsumerState<EditMed> createState() => _AddMedState();
}

class _AddMedState extends ConsumerState<EditMed> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Med _currentMed;

  Future<void> insertMed() async {
    try {
      await ref.read(medProvider.notifier).insert(_currentMed);
      MedResponse result = ref.read(medProvider);

      if (result.errorMsg.isNotEmpty) {        
        throw Exception(result.errorMsg);
      }

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Med inserito"))
      );

    } catch (e) {
      throw Exception("EDIT_MED_PAGE : Errore salvataggio : $e");
    }
  }

  //Future<void> editMed(Med med) async {}

  @override
  void initState() {
    super.initState();
    _currentMed = Med(id: 0, nome: "", compresse: 0, dosaggio: "");
  }

  void _cleanForm() {
    _currentMed = Med(id: 0, nome: "", compresse: 0, dosaggio: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Med",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: 
      Padding(
        padding: EdgeInsetsGeometry.all(12), 
        child: Center(
          child: Expanded (
            child: Container (
              decoration: BoxDecoration(),
              child: Form(
                key: _formKey, 
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder() 
                      ),
                      initialValue: _currentMed.nome,
                      onSaved: (value) {
                        _currentMed.nome = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Inserisci il nome";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Dosaggio",
                        border: OutlineInputBorder() 
                      ),
                      initialValue: _currentMed.dosaggio,
                      onSaved: (value) {
                        _currentMed.dosaggio = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Inserisci il dosaggio";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Numero compresse",
                        border: OutlineInputBorder() 
                      ),
                      initialValue: _currentMed.compresse.toString(),
                        onSaved: (value) {
                        _currentMed.compresse = int.tryParse(value ?? '') ?? 0;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Inserisci il numero di compresse";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 50),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () => insertMed(), child: Text("Salva")),
                        const SizedBox(width: 50),
                        ElevatedButton(onPressed: _cleanForm, child: Text("Pulisci")),
                      ],
                    )
                  ],
                )
              )
            ),
          )
        ),
      ),
    );
  }
}