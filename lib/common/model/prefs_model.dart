import 'package:mindit/sqlite/model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsModel extends ModelBase {
  final SharedPreferences prefs;
  PrefsModel({required this.prefs});
}
