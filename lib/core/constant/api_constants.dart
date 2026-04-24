class ApiConstants {
  static const String baseUrl = 'http://192.168.0.28:8080/v1'; // Ganti IP backend kamu

  static const String verifyToken = '/auth/verify-token';
  static const String products    = '/products';

  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;
}