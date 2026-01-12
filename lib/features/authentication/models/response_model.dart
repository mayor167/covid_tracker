class ResponseModel {
  final int statusCode;
  final String message;
  final dynamic data;

  // Constructor
  ResponseModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  // From JSON constructor
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      statusCode: json['statusCode'] ?? 200,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data,
    };
  }
}
