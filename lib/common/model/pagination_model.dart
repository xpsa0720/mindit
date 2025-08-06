import 'package:mindit/sqlite/model/base_model.dart';

class Pagination {
  paginate() {}
}

class PaginationLoading extends Pagination {}

class PaginationMore extends Pagination {}

class PaginationError extends Pagination {
  final String message;
  PaginationError({required this.message});
}
