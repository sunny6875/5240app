class ApiEndPoints {
  static const String baseUrl =
      'https://project5240.zatest.biz';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'auth/register';
  final String loginEmail = 'auth/login';
  final String location = 'auth/location';
  final String updateUser = 'auth/update_user';
  final String updatePassword = 'auth/update_password';
  final String forgetPassword = 'auth/forget';
  final String sendCode = 'api/send-code/send-code';
  final String allDomains = '/api/domains';
  final String allCategories = '/api/categories';
}