class ApiConstants {
  // BaseUrl
  static String baseUrl = 'https://taguigconnect.online';

  // Account
  static String registerUser = '/auth-register-user';
  static String verifyCode = '/auth-verify-otp';
  static String loginUser = '/auth-login-user';
  static String logoutUser = '/auth-logout-user';
  static String requestCode = '/auth-request-otp';
  static String resetPassword = '/auth-reset-password';
  static String changePassword = '/auth-change-password';

  // Data of the user
  static String newsEndpoint = '/user-news';
  static String barangayEndpoint = '/user-barangay';
  static String userReport = '/user-reports';
  static String feedReports = '/user-feed-reports';
  static String userEndpoint = '/users';
  static String reportEndpoint = '/reports';

  // Data for Moderator
  static String userInfoEndpoint = '/moderator-get-users';
  static String countTypeEndpoint = '/moderator-report-types';
  static String yearlyReportEndpoint = '/moderator-yearly-report';
  static String monthlyReportEndpoint = '/moderator-monthly-report';
  static String weeklyReportEndpoint = '/moderator-weekly-report';
  static String brgyInfoEndpoint = '/moderator-brgy-info';

  // Api Url for request
  static String apiUrl = '$baseUrl/api';
}
