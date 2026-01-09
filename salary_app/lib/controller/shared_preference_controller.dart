import 'package:get/get.dart';
import 'package:salary_app/service/shared_preference_service.dart';

enum Attendance { present, leave, absent }

class SalaryController extends GetxController {
  final basicSalary = 0.0.obs;
  final totalDays = 30.obs;
  final attendance = Attendance.present.obs;
  final totalSalary = 0.0.obs;

  static const double meal = 100;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    final data = await PreferenceService.load();
    basicSalary.value = data['basic'];
    totalDays.value = data['days'];
    calculate();
  }

  void calculate() {
    final fullSalary = basicSalary.value * 2;
    final nightAllowance = basicSalary.value * 0.20;

    final oneDay = fullSalary / totalDays.value;

    final nightAllowanceWithOneDay =
        (nightAllowance / totalDays.value) + meal + oneDay;

    double dailyValue = 0;

    if (attendance.value == Attendance.leave) {
      dailyValue = oneDay;
    } else if (attendance.value == Attendance.present) {
      dailyValue = nightAllowanceWithOneDay;
    }

    totalSalary.value = dailyValue * totalDays.value;

    PreferenceService.save(
      basicSalary.value,
      totalDays.value,
    );
  }
}
