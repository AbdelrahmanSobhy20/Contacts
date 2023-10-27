import 'package:contacts/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'contact_data.dart';
import 'contact_provider.dart';

class Details extends StatefulWidget {
  Contact contact;

  Details(this.contact);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController tename = TextEditingController();
  TextEditingController tephone = TextEditingController();
  TextEditingController teurl = TextEditingController();
  ContactProvider? provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tename.text = widget.contact.name;
    tephone.text = widget.contact.phoneNumber;
    teurl.text = widget.contact.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Contact Details",
          style: TextStyle(
            color: Color(0xFF0977CB),
            fontSize: 35,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(
              widget.contact.url,
              fit: BoxFit.fill,
            ),
            TextField(
              controller: tename,
              decoration: const InputDecoration(
                  hintText: "Contact Number",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: tephone,
              decoration: const InputDecoration(
                  hintText: "Contact Number",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextField(
              controller: teurl,
              decoration: const InputDecoration(
                  hintText: "Contact Number",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: AlertDialog(
                            title: const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to Save Changes of this Contact?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  ContactProvider.instance.update(Contact(
                                    id: widget.contact.id,
                                    name: widget.contact.name,
                                    phoneNumber: widget.contact.phoneNumber,
                                    url: widget.contact.url,
                                  ));
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });},
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });

                  setState(() {});
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: AlertDialog(
                            title: const Text(
                              'Delete Contact',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to Delete this Contact?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() async{
                                    var deleteContact = widget.contact.id;
                                    await provider?.delete(deleteContact!);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                                    print(deleteContact);
                                  });
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                  setState(() {});
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF0977CB),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
