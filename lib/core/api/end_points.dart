class EndPoints {
  static const String baseUrl = "https://balaghani.midadedev.com/api/v1";

  static const String login = "$baseUrl/customers/login";
  static const String register = "$baseUrl/customers/register";
  static const String logout = "$baseUrl/logout";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String deActivateAccount = "$baseUrl/reset-password";
  static const String deleteAccount = "$baseUrl/customers/destroy";
  static const String socialAuth = "$baseUrl/reset-password";
  static const String termsConditions = "$baseUrl/reset-password";
  static const String notifications = "$baseUrl/notifications";

  static const String items = "$baseUrl/items";
  static const String categories = "$baseUrl/categories";
  static const String aboutUs = "$baseUrl/aboutUs";
  static const String forgotSendCode = "$baseUrl/customers/forget/send";
  static const String verifyEmailCode = "$baseUrl/otps/verify";
  static const String verifyPasswordCode = "$baseUrl/otps/reset-password1";
  static const String chartStatistics = "$baseUrl/dashboard-chart";
  static const String resetPasswordWithCode =
      "$baseUrl/customers/forget/change";
  static const String passport = "$baseUrl/passport";
  static const String share = "$baseUrl/definitions/count-share";
  static const String emergencyNumbers = "$baseUrl/emergence-numbers";

  static const String profile = "$baseUrl/customers";
  static const String editProfile = "$baseUrl/customers/edit";
  static const String remembrancesCategories =
      "$baseUrl/remembrances/categories";
  static const String remembrances = "$baseUrl/remembrances";
  static const String toggleTavorite = "$baseUrl/toggle-favorite";
  static const String statistics = "$baseUrl/dashboard";
  static const String introductions = "$baseUrl/definitions";
  static const String invitations = "$baseUrl/invitations";
  static const String contactUs = "$baseUrl/contact_us";
  static const String getCountries = "$baseUrl/countries";
  static const String getLanguages = "$baseUrl/languages";
  static const String getReligions = "$baseUrl/religions";
  static const String getNationalities = "$baseUrl/nationalities";
  static const String orders = "$baseUrl/invitations";

  static const String sendToken = "$baseUrl/fcm-token";
  static const String uploadImage = "$baseUrl/customers/image";
}
