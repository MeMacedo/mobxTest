import 'package:app/services/shared_preferences_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'info_list.g.dart';

class InfoList extends _InfoListModel with _$InfoList {
  InfoList();

  factory InfoList.fromStringList(List<String> infoList) {
    final infos = InfoList();

    infos.infoList = ObservableList.of(infoList);

    return InfoList();
  }
}

@JsonSerializable()
abstract class _InfoListModel with Store {
  _InfoListModel();

  ObservableList<String> infoList = ObservableList<String>();

  @computed
  int get length => infoList.length;

  @action
  void addInfo(String description) async {
    infoList.add(description);
    await SharedPreferencesService().setInfos(infoList.toList());
  }

  @action
  void removeInfo(int index) async {
    infoList.removeAt(index);
    await SharedPreferencesService().setInfos(infoList.toList());
  }

  @action
  void editInfo(String info, int index) async {
    infoList[index] = info;
    await SharedPreferencesService().setInfos(infoList.toList());
  }
}
