import '../../common/data/color.dart';
import '../model/day_of_week_model.dart';
import '../model/task_model.dart';

final List<String> titles = [
  '운동하기',
  '명상하기',
  '책 읽기',
  '산책하기',
  '물 마시기',
  '일기 쓰기',
  '계획 세우기',
  '뉴스 읽기',
  '요리 연습',
  '영어 단어 외우기',
];

final List<String> descriptors = [
  '매일 30분 실천',
  '건강을 위한 루틴',
  '마음을 다스리기',
  '습관 만들기',
  '자기개발',
];

final List<String> mainColors = [
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
  pastelRedHex.toString(),
];

final List<List<DayOfWeek>> dayOfWeekPatterns = [
  [DayOfWeek.Mon, DayOfWeek.Wed, DayOfWeek.Fri],
  [DayOfWeek.Tue, DayOfWeek.Thu],
  [DayOfWeek.Sat, DayOfWeek.Sun],
  [DayOfWeek.Mon, DayOfWeek.Tue, DayOfWeek.Wed, DayOfWeek.Thu, DayOfWeek.Fri],
  [DayOfWeek.Sun],
  [DayOfWeek.Mon],
];

List<TaskModel> generateDummyTasks() {
  return List.generate(40, (index) {
    return TaskModel(
      title: titles[index % titles.length],
      dayOfWeekModel: DayOfWeekModel(
        dayOfWeek: dayOfWeekPatterns[index % dayOfWeekPatterns.length],
      ),
      descriptor: descriptors[index % descriptors.length],
      mainColor: mainColors[index % mainColors.length],
      implementationRate: (index % 11) * 9.1,
      sequenceDay: index % 15,
    );
  });
}
