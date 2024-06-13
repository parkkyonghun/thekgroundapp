class LoginResponse {
  final bool success;
  final dynamic result;
  final String message;

  LoginResponse({required this.success, this.result, required this.message});

  // Factory method to create LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      result: json['result'],
      message: json['message'],
    );
  }
}

class LoginData {
  final String email;
  final String password;
  final bool remember;

  LoginData(this.email, this.password, this.remember);
}