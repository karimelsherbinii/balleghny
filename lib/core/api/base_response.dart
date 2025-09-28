class BaseResponse<Type> {
  int? statusCode;
  String? message;
  bool? status;
  Type? data;
  int? currentPage;
  int? lastPage;
  int? unReadTotal;

  BaseResponse({
    this.statusCode,
    this.message,
    this.status,
    this.data,
    this.currentPage,
    this.lastPage,
    this.unReadTotal,
  });
}
