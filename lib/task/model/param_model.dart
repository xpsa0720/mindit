class TaskModel_Praram {
  final int start_id;
  final int end_id;
  final int length;
  final bool fetchMore;
  TaskModel_Praram({
    required this.length,
    required this.start_id,
    required this.end_id,
    this.fetchMore = false,
  });
}
