import 'package:contact_list/domain/contact.dart';

List <Contact> _contacts = [];

class ContactDAO {

  void create(Contact contact){
    _contacts.add(contact);
  }

  List<Contact> listContacts(){
    return _contacts;
  }

  void deleteContact(Contact contact){
    _contacts.remove(contact);
  }
}