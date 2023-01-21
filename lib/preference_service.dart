import 'package:shared_preferences/shared_preferences.dart';
import './models.dart';

class PreferenceServices {
  // this function will exicute after calling it out in main function
  Future saveSettings(Setting setting) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('usernmae', setting.username);
    await preferences.setInt('gender', setting.gender.index);
    await preferences.setBool('isemployed', setting.isEmployed);
    await preferences.setStringList(
        'programminglanguages',
        setting.programmingLanguages
            .map((entries) => entries.index.toString())
            .toList());

    // after exicuting this function we simply print  a text
    print('saved settings');
  }

  /// after completing this task we need to get or retrive all the data

  Future<Setting> getSetting() async {
    final preferences = await SharedPreferences.getInstance();

    final userName = preferences.getString('usernmae');
    final isEmployr = preferences.getBool('isemployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];

    final programminglanguagesIndicies =
        preferences.getStringList('programminglanguages');

    final programmingLanguages = programminglanguagesIndicies!
        .map((stringIndex) =>
            ProgrammingLanguages.values[int.parse(stringIndex)])
        .toSet();

    return Setting(
        username: userName.toString(),
        gender: gender,
        programmingLanguages: programmingLanguages,
        isEmployed: isEmployr!);
  }
}
