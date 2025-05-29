abstract class ModelBase {}

class ModelLoading extends ModelBase {}

class ModelError extends ModelBase {
  final String message;
  ModelError({required this.message});
}
