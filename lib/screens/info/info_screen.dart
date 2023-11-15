import 'package:app/components/common/privacy_policy.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    infos = SharedPreferencesService().getInfos();
    super.initState();
  }

  FocusNode inputFocus = FocusNode();

  late final List<String>? infos;

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
                infos?.removeAt(index);
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
        Text(infos?[index] ?? ''),
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
      color: Colors.white,
      child: Column(
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (context, index) => _getInfoCard(index, context),
            itemCount: infos?.length ?? 0,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  Form _getInfoInput() {
    return Form(
      key: _formKey,
      child: TextFormField(
        onFieldSubmitted: (input) async {
          if (_formKey.currentState!.validate()) {
            infos?.add(input);
            await SharedPreferencesService().setInfos(infos ?? []);
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
            _getInfoListing(context),
            _getInfoInput(),
            const PrivacyPolicy()
          ],
        ),
      ),
    );
  }
}
