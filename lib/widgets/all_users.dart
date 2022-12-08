import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invite_user/theme/theme.dart' as theme;
import 'package:invite_user/theme/theme.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);
  @override
  InviteUserState createState() => InviteUserState();
}

class InviteUserState extends State<AllUser> {
  dynamic dataMap = {};
  dynamic userList = {};

  String name = '';
  String email = '';
  String firstName = '';
  String lastName = '';
  String admin = '';
  String configName = '';
  bool status = false;

  getAllItems() async {
    await getMember();
  }

  Future<dynamic> getMember() async {
    var api =
        "https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/company/6dc9858b-b9eb-4248-a210-0f1f08463658/teams";
    String token = Global.token;
    ;
    var response = await http.get(Uri.parse(api), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'authtoken': token,
    });

    userList = response.body;

    var statusCode = jsonDecode(response.body);

    if (statusCode["error_flag"] == "SUCCESS") {
      snackBar(statusCode['message']);
    } else {
      snackBar(statusCode['message']);
    }

    return json.decode(userList);
  }

  snackBar(String statusCode) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(statusCode),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  getAllContacts() {
    var userData = jsonDecode(userList);
    List<dynamic> allContacts = userData['data']['contacts'];
    List<Widget> contactWidgets = [];

    for (var contact in allContacts) {
      if (contact['firstname'] != null &&
          contact['lastname'] != null &&
          contact['role_name'] != null &&
          contact['isactive'] != null) {
        name = contact['firstname'] + ' ' + contact['lastname'];
        firstName = contact['firstname'][0];
        lastName = contact['lastname'][0];
        admin = contact['role_name'];
        status = contact['isactive'];

        contactWidgets.add(Container(
            child: getContactUI(firstName, lastName, name, admin, status)));
      }
    }
    return contactWidgets;
  }

  getAllInvites() {
    var userData = jsonDecode(userList);
    List<dynamic> allInvites = userData['data']['invites'];
    List<Widget> inviteWidgets = [];
    for (var invite in allInvites) {
      if (invite['email'] != null && invite['config_name'] != null) {
        firstName = invite['email'][0];
        lastName = invite['email'][1];
        email = invite['email'];
        configName = invite['config_name'];
        inviteWidgets.add(Container(
            child: getInviteUI(firstName, lastName, email, configName)));
      }
    }

    return inviteWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.grey.shade100,
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Teams',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0,
                                        fontFamily: 'Heebo',
                                        color: Colors.black),
                                  ))
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.search))
                            ])
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('All Contacts',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: HexColor('#75808A'))))
                          ]),
                          Column(children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.25),
                                    ),
                                    onPressed: () async {}))
                          ])
                        ]),
                    Row(
                      children: [
                        Column(
                          children: getAllContacts(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('All Invites',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: HexColor('#75808A'))))
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        child: const Text(
                                          "See all",
                                          style: TextStyle(
                                              fontFamily: 'Noto Sans',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              letterSpacing: 0.25),
                                        ),
                                        onPressed: () async {}))
                              ])
                        ]),
                    Row(
                      children: [
                        Column(
                          children: getAllInvites(),
                        )
                      ],
                    ),
                  ],
                )) //getContactUI(firstName1, lastName1, name), //Center
                );
          }
          return const CircularProgressIndicator();
        });
  }

  Container getContactUI(String firstName, String lastName, String name,
      String admin, bool status) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.all(
        6.0,
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: HexColor('#1A62C6'),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      '$firstName' '$lastName',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: HexColor('#F4F4F4')),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.black))),
                                const SizedBox(height: 5.0),
                                // Text(admin,
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 14,
                                //         color: Colors.black)),
                                Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      // ignore: unrelated_type_equality_checks
                                      status.toString() == 'true'
                                          ? 'Active'
                                          : 'Inactive',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: HexColor('#75808A')),
                                    ))
                              ],
                            )),
                      ])
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 10,
              ),
              Row(
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(admin,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black))),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getInviteUI(
      String firstName, String lastName, String email, String configName) {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        margin: const EdgeInsets.all(
          6.0,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: HexColor('#AC816E'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        '$firstName' '$lastName',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: HexColor('#F4F4F4')),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(email,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black))),
                            const SizedBox(height: 5.0),
                            // Text(admin,
                            //     style: const TextStyle(
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: 14,
                            //         color: Colors.black)),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  // ignore: unrelated_type_equality_checks
                                  configName,

                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: HexColor('#75808A')),
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  buildNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: theme.iconPrimary,
                    size: 24,
                  )),
              Text(
                'Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Sans',
                    color: theme.iconPrimary),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.monetization_on_rounded,
                    color: theme.iconPrimary,
                    size: 24,
                  )),
              Text(
                'Loans',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Sans',
                    color: theme.iconPrimary),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllUser()));
                  },
                  icon: Icon(
                    Icons.file_copy,
                    color: theme.iconPrimary,
                    size: 24,
                  )),
              Text(
                'Contacts',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Sans',
                    color: theme.iconPrimary),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: theme.iconPrimary,
                    size: 24,
                  )),
              Text(
                'Teams',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Sans',
                    color: theme.iconPrimary),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: theme.iconPrimary,
                    size: 24,
                  )),
              Text(
                'Chats',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Sans',
                    color: theme.iconPrimary),
              )
            ],
          ),
        ],
      ),
    );
  }
}
