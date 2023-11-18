// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoList on _InfoListModel, Store {
  Computed<int>? _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??=
          Computed<int>(() => super.length, name: '_InfoListModel.length'))
      .value;

  late final _$addInfoAsyncAction =
      AsyncAction('_InfoListModel.addInfo', context: context);

  @override
  Future<void> addInfo(String description) {
    return _$addInfoAsyncAction.run(() => super.addInfo(description));
  }

  late final _$removeInfoAsyncAction =
      AsyncAction('_InfoListModel.removeInfo', context: context);

  @override
  Future<void> removeInfo(int index) {
    return _$removeInfoAsyncAction.run(() => super.removeInfo(index));
  }

  late final _$editInfoAsyncAction =
      AsyncAction('_InfoListModel.editInfo', context: context);

  @override
  Future<void> editInfo(String info, int index) {
    return _$editInfoAsyncAction.run(() => super.editInfo(info, index));
  }

  @override
  String toString() {
    return '''
length: ${length}
    ''';
  }
}
