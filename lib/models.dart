enum Gender { MALE, FEMALE, OTHERS }

enum ProgrammingLanguages {
  KOTLIN,
  DART,
  JAVA,
  PYTHON,
}

class Setting {
  final String username;
  final Gender gender;
  final Set<ProgrammingLanguages> programmingLanguages;
  final bool isEmployed;

  Setting(
      {required this.username,
      required this.gender,
      required this.programmingLanguages,
      required this.isEmployed});
}
