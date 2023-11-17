// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoList on _InfoListModel, Store {
  late final _$_InfoListModelActionController =
      ActionController(name: '_InfoListModel', context: context);

  @override
  void addInfo(String description) {
    final _$actionInfo = _$_InfoListModelActionController.startAction(
        name: '_InfoListModel.addInfo');
    try {
      return super.addInfo(description);
    } finally {
      _$_InfoListModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeInfo(int index) {
    final _$actionInfo = _$_InfoListModelActionController.startAction(
        name: '_InfoListModel.removeInfo');
    try {
      return super.removeInfo(index);
    } finally {
      _$_InfoListModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
