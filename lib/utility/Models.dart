class ResponseModel {
  final bool status;
  final String message;
  final String token;


  const ResponseModel({
    required this.status,
    required this.message,
    required this.token
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        status: json['status'],
        message: json['message'],
        token: json['token']??"null"
    );
  }

  factory ResponseModel.registerFromJson(Map<String, dynamic> json) {
    return ResponseModel(
        status: json['status'],
        message: json['message'],
        token: "null"
    );
  }
}

class RequestModel {
  final String username, password, fullName, email;

  const RequestModel(
    {
      this.fullName = '',
      this.email = '',
      required this.username,
      required this.password
    }
  );
  const RequestModel.register({
    required this.username,
    required this.password,
    required this.fullName,
    required this.email
  });

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'username' : username,
      'password' : password,
      'full_name' : fullName,
      'email' : email
    };
  }
}