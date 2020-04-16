/* 思考如果通过协议进行泛型化 */
abstract class BaseResponse<T> {
  T data;
  int errorCode;
  String errorMsg;

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return null;
  }

  Map<String, dynamic> toJson();
}