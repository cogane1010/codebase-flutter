import 'package:brg_management/resources/enums.dart';
import 'package:global_configuration/global_configuration.dart';

class AppConfig {
  GlobalConfiguration get globalConfiguration => GlobalConfiguration();

  static final AppConfig _singleton = AppConfig._internal();

  static AppConfig get instance => _singleton;

  AppConfig._internal();

  Future loadConfig({Environment env = Environment.dev}) async {
    final appEnv = env.value;
    await GlobalConfiguration().loadFromAsset('app_config_$appEnv');
  }

  String get apiEndpoint => globalConfiguration.getValue<String>('apiEndpoint');
  String get apiEndpointBooking =>
      globalConfiguration.getValue<String>('apiEndpointBookings');
  String get promotionApiEndpoint =>
      globalConfiguration.getValue<String>('promotionApiEndpoint');
  String get messageEn => globalConfiguration.getValue<String>('messageEn');
  String get messageVn => globalConfiguration.getValue<String>('messageVn');
}
