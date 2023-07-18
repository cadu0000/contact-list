import 'package:flutter/material.dart';
import 'package:contact_list/domain/contact.dart';
import 'package:contact_list/db/contact.dart';

import 'contact_view.dart';

class HomeView extends StatefulWidget {
  final contactDAO = ContactDAO();
  HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Contact> itensSelecionados = [];
  List<Contact> contacts = [];

  void deleteItens() {
    for (var contact in itensSelecionados) {
      widget.contactDAO.deleteContact(contact);
      contacts.remove(contact);
    }

    setState(() {
      itensSelecionados.clear();
    });
  }

  void chooseContact(Contact contact) {
    setState(() {
      if (itensSelecionados.contains(contact)) {
        itensSelecionados.remove(contact);
      }
      itensSelecionados.add(contact);
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return itensSelecionados.isEmpty
        ? AppBar(
            title: const Text("Contacts List"),
            centerTitle: true,
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

  ListTile list(BuildContext context, int i) {
    return ListTile(
      onLongPress: () {
        chooseContact(contacts[i]);
      },
      leading: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        height: 40,
        width: 40,
        child: buildRoundContainerChild(contacts[i]),
      ),
    );
  }

  Widget buildRoundContainerChild(Contact contact) {
    var letra = Text(
      contact.name[0].toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
    );

    const checkBox = Icon(Icons.check);
    return itensSelecionados.contains(contact) ? checkBox : letra;
  }

  void openContactRoute() async {
    await Navigator.pushNamed(context, ContactView.route);
    updateContact();
  }

  void updateContact() {
    setState(() {
      contacts = widget.contactDAO.listContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: itensSelecionados.length,
        itemBuilder: list,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openContactRoute,
      ),
    );
  }
}
