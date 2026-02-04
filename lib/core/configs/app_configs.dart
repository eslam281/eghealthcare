enum Environment { dev, prod }

Environment getEnvironmentFromString(String env) {
  switch (env) {
    case 'prod':
      return Environment.prod;
    default:
      return Environment.dev;
  }
}
class AppConfig {
  final String baseUrl;
  final bool enableLogs;

  AppConfig._({
    required this.baseUrl,
    required this.enableLogs,
  });

  static late AppConfig instance;

  static void initialize(Environment env) {
    switch (env) {
      case Environment.dev:
        instance = AppConfig._(
          baseUrl: "https://dev-api.com",
          enableLogs: true,
        );
        break;
      case Environment.prod:
        instance = AppConfig._(
          baseUrl: "https://api.com",
          enableLogs: false,
        );
        break;
    }
  }
}
