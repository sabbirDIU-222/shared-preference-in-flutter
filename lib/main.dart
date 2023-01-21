import 'package:flutter/material.dart';
import './models.dart';
import './preference_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

// we work on this class
class _MyAppState extends State<MyApp> {
  final _preferenceService = PreferenceServices();

  final _textEditingController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<ProgrammingLanguages>();
  var _isEmpoyed = false;

  @override
  void initState() {
    super.initState();
    _populateField();
  }

  void _populateField() async {
    final settings = await _preferenceService.getSetting();

    setState(() {
      _textEditingController.text = settings.username;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.programmingLanguages;
      _isEmpoyed = settings.isEmployed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preference',
      home: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text('user\'s settings'),
          centerTitle: true,
        ),
        body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              title: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(labelText: 'user name'),
              ),
            ),
            RadioListTile(
              title: Text('female'),
              activeColor: Colors.pink,
              value: Gender.FEMALE,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() {
                _selectedGender = value!;
              }),
            ),
            RadioListTile(
              title: Text('male'),
              activeColor: Colors.red,
              value: Gender.MALE,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() {
                _selectedGender = value!;
              }),
            ),
            RadioListTile(
              title: Text('others'),
              value: Gender.OTHERS,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() {
                _selectedGender = value!;
              }),
            ),

            // under that we create check box if a user know programming languages or not
            CheckboxListTile(
              title: const Text('Kotlin'),
              value: _selectedLanguages.contains(ProgrammingLanguages.KOTLIN),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.KOTLIN)
                      ? _selectedLanguages.remove(ProgrammingLanguages.KOTLIN)
                      : _selectedLanguages.add(ProgrammingLanguages.KOTLIN);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Dart'),
              value: _selectedLanguages.contains(ProgrammingLanguages.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguages.DART)
                      : _selectedLanguages.add(ProgrammingLanguages.DART);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('java'),
              value: _selectedLanguages.contains(ProgrammingLanguages.JAVA),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.JAVA)
                      ? _selectedLanguages.remove(ProgrammingLanguages.JAVA)
                      : _selectedLanguages.add(ProgrammingLanguages.JAVA);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('python'),
              value: _selectedLanguages.contains(ProgrammingLanguages.PYTHON),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.PYTHON)
                      ? _selectedLanguages.remove(ProgrammingLanguages.PYTHON)
                      : _selectedLanguages.add(ProgrammingLanguages.PYTHON);
                });
              },
            ),

            // make a switch button to fairly asked if a user employed or not
            SwitchListTile(
              title: Text('Is employed'),
              value: _isEmpoyed,
              onChanged: (newvalue) {
                setState(() {
                  _isEmpoyed = newvalue;
                });
              },
            ),

            TextButton(
              onPressed: _saveSettings,
              child: Text('save settings'),
            )
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    final newSetting = Setting(
        username: _textEditingController.text,
        gender: _selectedGender,
        programmingLanguages: _selectedLanguages,
        isEmployed: _isEmpoyed);

    print(newSetting);
    _preferenceService.saveSettings(newSetting);
  }
}
