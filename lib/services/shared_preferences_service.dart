import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      _prefInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefInstance;

  static Future<void> init() async {
    _prefInstance = await _instance;
  }

  List<String>? getInfos() {
    return _prefInstance?.getStringList('Infos');
  }

  setInfos(List<String> infos) async {
    try {
      await _prefInstance?.setStringList('Infos', infos);
    } catch (e) {}
  }
}
