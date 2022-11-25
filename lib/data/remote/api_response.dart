import 'package:news_flutter_block/data/remote/status.dart';

class ApiResponse<T> {

  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading() : status = Status.apiLoading;

  ApiResponse.completed(this.data) : status = Status.apiComplete;

  ApiResponse.error(this.message) : status = Status.apiError;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}