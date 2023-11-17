import 'package:app/components/common/privacy_policy.dart';
import 'package:app/models/observables/info_list.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    infos =
        InfoList.fromStringList(SharedPreferencesService().getInfos() ?? []);
    super.initState();
  }

  FocusNode inputFocus = FocusNode();

  late final InfoList infos;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _confirmDeletion(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja mesmo deletar informação?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sim'),
              onPressed: () {
                infos.removeInfo(index);
              },
            ),
          ],
        );
      },
    );
  }

  _getInfoCard(int index, BuildContext context) {
    return Row(
      children: [
        Text(infos.infoList[index]),
        const Icon(Icons.person),
        IconButton(
          onPressed: () => _confirmDeletion(context, index),
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Container _getInfoListing(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      height: 100,
      color: Colors.white,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) => _getInfoCard(index, context),
        itemCount: infos.length,
      ),
    );
  }

  Form _getInfoInput() {
    return Form(
      key: _formKey,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          fillColor: Colors.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          hintText: "Digite seu texto",
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onFieldSubmitted: (input) async {
          if (_formKey.currentState!.validate()) {
            infos.addInfo(input);
          }
          inputFocus.requestFocus();
        },
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "Preencha a informação.";
          }
          return null;
        },
        autofocus: true,
        focusNode: inputFocus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal,
              Colors.blue,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 20,
              ),
              child: _getInfoListing(context),
            ),
            _getInfoInput(),
            const Spacer(),
            const PrivacyPolicy(),
          ],
        ),
      ),
    );
  }
}
