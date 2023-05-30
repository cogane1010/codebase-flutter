enum Environment { dev, prod, uat , stg }
enum Language { vi, en }

extension EnvironmentExt on Environment {
  String get value => ['dev', 'prod', 'uat', 'stg'][index];
}
extension LanguageExt on Language {
  String get value => ['vi', 'en'][index];
}



