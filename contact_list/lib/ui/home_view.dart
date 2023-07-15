import 'package:flutter/material.dart';
import 'package:contact_list/domain/contact.dart';
import 'package:contact_list/db/contact.dart';

class HomeView extends StatefulWidget {
  final contactDAO = ContactDAO();
  HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Contact> itensSelecionados = [];
  List<Contact> contacts = [];

  void deleteItens(){
    for (var contact in itensSelecionados) {
      widget.contactDAO.deleteContact(contact);
      contacts.remove(contact);
    }

    setState(() {
      itensSelecionados.clear();
    });

  }

  AppBar buildAppBar(BuildContext context) {
    return itensSelecionados.isEmpty
        ? AppBar(
            title: const Text("Contacts List"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          )
        : AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  itensSelecionados.clear();
                });
              },
            ),
            actions: [
              IconButton(
                onPressed: deleteItens,
                icon: const Icon(Icons.delete),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
    );
  }
}
