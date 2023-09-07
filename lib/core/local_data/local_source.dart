import 'package:shared_preferences/shared_preferences.dart';


class LocalSource{
  final SharedPreferences preferences;
  LocalSource(this.preferences);
  String key = 'client';
  String timeKey = 'start';

  void setClientName({required String name, required String surname}){
    preferences.setString(key, '$name $surname');
  }
  String getClientName(){
    return preferences.getString(key) ?? '';
  }
  bool dataExist(){
    return preferences.containsKey(key);
  }

  void setStartTime(bool isStart){
    preferences.setBool(timeKey, isStart);
  }
  bool startTime(){
    return preferences.containsKey(timeKey);
  }

  void removeStart(){
    preferences.remove(timeKey);
  }
}


