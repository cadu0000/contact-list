import 'package:contact_list/db/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/contact.dart';
import '../utils/validation.dart';

class ContactView extends StatefulWidget {
  static const String route = "/contato";
  const ContactView({super.key});

  @override
  State<StatefulWidget> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _nomeFieldController = TextEditingController();
  final _phoneFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void saveContact() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Tá errado")));
      return;
    }
    var name = _nomeFieldController.text;
    var number = _phoneFieldController.text;
    var email = _emailFieldController.text;

    try {
      var contact = Contact(name: name, number: number, email: email);

      var dao = ContactDAO();
      dao.create(contact);

      Navigator.pop(context, contact);
    } on FormatException catch (e) {
      buildMessageError(context) {
        return AlertDialog(
          title: const Text("Não foi possível salvar o contato"),
          content: Text(e.message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ok"),
            )
          ],
        );
      }

      showDialog(context: context, builder: buildMessageError);
    }
  }

  Padding wrapWithDefaultPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrapWithDefaultPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome"),
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Digite um nome válido";
                      }
                      return null;
                    },
                    controller: _nomeFieldController,
                  ),
                ],
              ),
            ),
            const Text("Telefone"),
            TextFormField(
              //validar aqui
              controller: _phoneFieldController,
            ),
            const Text("Email"),
            TextFormField(
              controller: _emailFieldController,
            ),
            TextButton(
              onPressed: saveContact,
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}
