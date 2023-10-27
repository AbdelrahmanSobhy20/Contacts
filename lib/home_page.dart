import 'package:contacts/contact_data.dart';
import 'package:contacts/contact_provider.dart';
import 'package:flutter/material.dart';

import 'contact_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contactList = [];
  TextEditingController contactName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController contactImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
              builder: ((context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  height: 280,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: contactName,
                        decoration: const InputDecoration(
                            hintText: "Contact Name",
                            hintStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: contactNumber,
                        decoration: const InputDecoration(
                            hintText: "Contact Number",
                            hintStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: contactImage,
                        decoration: const InputDecoration(
                            hintText: "Contact Image URL",
                            hintStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0977CB),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            ContactProvider.instance.insert(Contact(
                              name: contactName.text,
                              phoneNumber: contactNumber.text,
                              url: contactImage.text,
                            ));
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: const Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }));
        },
        elevation: 0,
        backgroundColor: const Color(0xFF0977CB),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "My Contacts",
          style: TextStyle(
            color: Color(0xFF0977CB),
            fontSize: 35,
          ),
        ),
      ),
      body: FutureBuilder<List<Contact>>(
        future: ContactProvider.instance.getAllContacts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            contactList = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 400,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: contactList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = contactList[index];
                    return Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 140,
                              width: 140,
                              child: Image.network(
                                contact.url,
                                fit: BoxFit.fill,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details(contact)));
                            },
                          ),
                          Text(
                            contact.name,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            contact.phoneNumber,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
