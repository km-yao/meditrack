import 'package:flutter/material.dart';
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
      // Aggoirna la data di scadenza in base alla data di prelievo e al numero di compresse
      _currentMed.scadenza = _currentMed.prelievo.add(Duration(days: _currentMed.compresse));

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
    _currentMed = Med(id: 0, nome: "", compresse: 0, dosaggio: "", prelievo: DateTime.now(), scadenza: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: 
      Padding(
        padding: EdgeInsetsGeometry.all(16), 
        child: Center(
          child: Form(
            key: _formKey, 
            child: Column(
              spacing: 30,
              children: [
                
                Flexible(child: Text("Inserisci un nuovo med", style: TextStyle(fontSize: 28))),
                    
                // NOME
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder() 
                    ),
                    initialValue: _currentMed.nome,
                    onSaved: (value) {
                      _currentMed.nome = value!;
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentMed.nome = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Inserisci il nome";
                      }
                      return null;
                    },
                  ),
                ),
                    
                // DOSAGGIO
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Dosaggio",
                    border: OutlineInputBorder() 
                  ),
                  initialValue: _currentMed.dosaggio,
                  onSaved: (value) {
                    _currentMed.dosaggio = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentMed.dosaggio = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Inserisci il dosaggio";
                    }
                    return null;
                  },
                ),
                    
                // NUMERO COMPRESSE
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "20",
                    labelText: "Numero compresse",
                    border: OutlineInputBorder() 
                  ),
                  initialValue: _currentMed.compresse.toString(),
                  onSaved: (value) {
                    _currentMed.compresse = int.tryParse(value ?? '') ?? 0;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentMed.compresse = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty || int.parse(value) == 0) {
                      return "Inserisci il numero di compresse";
                    }
                    return null;
                  },
                ),
                    
                // DATA PRELIEVO
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Data prelievo",
                      border: OutlineInputBorder() 
                    ),
                    
                    controller: TextEditingController(text: _currentMed.prelievo.toLocal().toString().split(' ')[0]),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _currentMed.prelievo = pickedDate;
                        });
                      }
                    },
                    onSaved: (value) {
                      _currentMed.prelievo =  DateTime.parse(value as String);
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentMed.prelievo = DateTime.parse(value);
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Inserisci la data di prelievo";
                      }
                      return null;
                    }
                  ),
                ),
                    
                const SizedBox(height: 20),
                    
                // BOTTONI SALVA / ANNULLA
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            insertMed();
                          }
                        },
                        label: Text("Salva"),
                        icon: Icon(Icons.check) 
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton.icon(
                        onPressed: () { Navigator.pop(context); },
                        label: Text("Annulla"),
                        icon: Icon(Icons.close),
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }
}