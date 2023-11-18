import 'package:app/components/common/privacy_policy.dart';
import 'package:app/main.dart';
import 'package:app/models/observables/info_list.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart' as Mob;

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final TextEditingController _textController = TextEditingController();
  String helpText = "Digite seu texto";
  int currentIndex = 0;
  FocusNode inputFocus = FocusNode();

  final InfoList infos =
      InfoList.fromStringList(SharedPreferencesService().getInfos() ?? []);

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
              onPressed: () async {
                await infos.removeInfo(index);
                navigatorKey.currentState?.pop();
              },
            ),
          ],
        );
      },
    );
  }

  _editInfo(index) {
    setState(() {
      helpText = "Edite seu texto";
      currentIndex = index;
    });
  }

  _getInfoCard(int index, BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 24,
          ),
          child: Text(
            infos.infoList[index],
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
          onPressed: () {
            _editInfo(index);
          },
        ),
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
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Observer(
          builder: (_) => ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (context, index) => _getInfoCard(index, context),
            itemCount: infos.length,
          ),
        ));
  }

  Form _getInfoInput() {
    return Form(
      key: _formKey,
      child: Observer(
        builder: (_) => TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.white,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            hintText: helpText,
            hintStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onFieldSubmitted: (input) async {
            if (_formKey.currentState!.validate()) {
              if (helpText == "Digite seu texto") {
                infos.addInfo(input);
              } else {
                await infos.editInfo(input, currentIndex);
              }
            }
            setState(() {
              helpText = "Digite seu texto";
              _textController.text = '';
            });
            inputFocus.requestFocus();
          },
          controller: _textController,
          validator: (input) {
            if (input == null || input.isEmpty) {
              return "Preencha a informação.";
            }
            return null;
          },
          autofocus: true,
          focusNode: inputFocus,
        ),
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
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
