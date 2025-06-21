abstract class ModelBase {}

class ModelLoading extends ModelBase {}

class ModelError extends ModelBase {
  final String message;
  final bool? jsonNull;
  ModelError({required this.message, this.jsonNull});
}
