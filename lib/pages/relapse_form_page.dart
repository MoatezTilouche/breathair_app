import 'dart:convert';
import 'package:breathair_app/pages/relapse_report_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelapseFormPage extends StatefulWidget {
  @override
  _RelapseFormPageState createState() => _RelapseFormPageState();
}

class _RelapseFormPageState extends State<RelapseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _triggerController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _hadAlcohol = false;
  bool _wasAlone = false;

  final String apiUrl = 'http://localhost:3000/smoking/advice';

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final analysis = {
        'timestamp': DateTime.now().toString(),
        'location': _locationController.text,
        'mood': _moodController.text.isEmpty ? 'Neutre' : _moodController.text,
        'wasAlone': _wasAlone,
        'hadAlcohol': _hadAlcohol,
        'triggerDescription': _triggerController.text,
        'cravingIntensity': 7,
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(analysis),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return RelapseReportDialog(analysis: responseData);
            },
          ).then((value) {
            if (value == null) {
              // Reset form fields when the dialog is dismissed
              _formKey.currentState?.reset();
              _triggerController.clear();
              _moodController.clear();
              _locationController.clear();
              setState(() {
                _hadAlcohol = false;
                _wasAlone = false;
              });
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Erreur du serveur: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ Erreur de connexion: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Analyse de la rechute', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_triggerController, 'Déclencheur principal'),
              SizedBox(height: 16),
              _buildTextField(_moodController, 'Émotion ressentie'),
              SizedBox(height: 16),
              _buildTextField(_locationController, 'Lieu de la rechute'),
              SizedBox(height: 16),
              _buildSwitchTile('Aviez-vous consommé de l\'alcool ?', _hadAlcohol, (val) {
                setState(() => _hadAlcohol = val);
              }),
              _buildSwitchTile('Étiez-vous seul(e) ?', _wasAlone, (val) {
                setState(() => _wasAlone = val);
              }),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Analyser la rechute', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.black)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }
}
