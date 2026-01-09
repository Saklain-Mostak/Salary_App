import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const _basicSalary = 'basic_salary';
  static const _days = 'days';

  static Future<void> save(double basic, int days) async {
    final pref = await SharedPreferences.getInstance();
    pref.setDouble(_basicSalary, basic);
    pref.setInt(_days, days);
  }

  static Future<Map<String, dynamic>> load() async {
    final pref = await SharedPreferences.getInstance();
    return {
      'basic': pref.getDouble(_basicSalary) ?? 0,
      'days': pref.getInt(_days) ?? 30,
    };
  }
}
