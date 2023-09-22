import 'package:shared_preferences/shared_preferences.dart';

class LocalSource {
  final SharedPreferences preferences;

  LocalSource(this.preferences);

  String key = 'client';
  String timeKey = 'start';
  String dateTime = 'dateTime';

  ///save client data
  void setClientName({required String name}) {
    preferences.setString(key, name);
  }

  String getClientName() {
    return preferences.getString(key) ?? '';
  }

  bool dataExist() {
    return preferences.containsKey(key);
  }

  void deleteData() {
    preferences.remove(key);
  }

  ///save client start work
  void setStartTime(bool isStart) {
    preferences.setBool(timeKey, isStart);
  }

  bool startTime() {
    return preferences.containsKey(timeKey);
  }

  void removeStart() {
    preferences.remove(timeKey);
  }

  ///save client start time
  void saveDateTime(String date) {
    preferences.setString(dateTime, date);
  }

  String getDateTime() {
    return preferences.getString(dateTime) ?? '';
  }

  deleteDateTime() {
    preferences.remove(dateTime);
  }
}
