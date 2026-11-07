class AppConfig {
  const AppConfig._();

  static const appName = 'AllergyCheck';
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
}