import 'dart:ui';

import 'package:mindit/common/data/data.dart';
import 'package:mindit/task/model/day_of_week_model.dart';

class DataUtils {
  static Color intToColor(int int_Color) {
    return Color(0xFF000000 + int_Color);
  }

  static List<DayOfWeek> generateDayOfWeekList(List<bool> list) {
    List<DayOfWeek> return_list = [];
    List.generate(list.length, (index) {
      if (list[index]) {
        return_list.add(All_DayOfWeek_list[index]);
      }
    });
    return return_list;
  }

  static String dayOfWeekToJsonData(DayOfWeekModel model) {
    String json_string = "";
    for (final v in model.dayOfWeek) {
      switch (v) {
        case DayOfWeek.Mon:
          json_string += "Mon;";
        case DayOfWeek.Tue:
          json_string += "Tue;";
        case DayOfWeek.Wed:
          json_string += "Wed;";
        case DayOfWeek.Thu:
          json_string += "Thu;";
        case DayOfWeek.Fri:
          json_string += "Fri;";
        case DayOfWeek.Sat:
          json_string += "Sat;";
        case DayOfWeek.Sun:
          json_string += "Sun;";
      }
    }
    return json_string;
  }

  static PapagoEnglishtoKorea(List<String> list) {
    List<String> return_string = [];
    List.generate(list.length, (index) {
      switch (list[index]) {
        case 'Mon':
          return_string.add('월');
          return_string.add(' · ');
        case 'Tue':
          return_string.add('화');
          return_string.add(' · ');
        case 'Wed':
          return_string.add('수');
          return_string.add(' · ');
        case 'Thu':
          return_string.add('목');
          return_string.add(' · ');
        case 'Fri':
          return_string.add('금');
          return_string.add(' · ');
        case 'Sat':
          return_string.add('토');
          return_string.add(' · ');
        case 'Sun':
          return_string.add('일');
          return_string.add(' · ');
      }
    });
    return return_string.sublist(0, return_string.length - 1);
  }

  static List<DayOfWeek> StringDataToDayOfWeek(String data) {
    final data_list = data.split(';');
    List<DayOfWeek> model = [];
    for (final v in data_list) {
      switch (v) {
        case 'Mon':
          model.add(DayOfWeek.Mon);
        case 'Tue':
          model.add(DayOfWeek.Tue);
        case 'Wed':
          model.add(DayOfWeek.Wed);
        case 'Thu':
          model.add(DayOfWeek.Thu);
        case 'Fri':
          model.add(DayOfWeek.Fri);
        case 'Sat':
          model.add(DayOfWeek.Sat);
        case 'Sun':
          model.add(DayOfWeek.Sun);
      }
    }
    return model;
  }
}
