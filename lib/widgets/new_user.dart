import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invite_user/theme/theme.dart';
import 'package:invite_user/widgets/dropdown.dart';
import 'package:http/http.dart' as http;

class InviteUser extends StatefulWidget {
  const InviteUser({Key? key}) : super(key: key);
  @override
  InviteUserState createState() => InviteUserState();
}

class InviteUserState extends State<InviteUser> {
  dynamic dataMap = {};
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  String? newValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _inviteMember();
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#0CABDF'),
                ),
                child: const Text('Continue',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 24,
                      ),
                    ))
              ],
            ),
            Row(children: const [
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Invite',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 34.0,
                        fontFamily: 'Heebo',
                        color: Colors.black),
                  ))
            ]),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: text1,
                  onChanged: (value) {
                    dataMap['email'] = value;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            BorderSide(color: Colors.blue.shade100, width: 1.0),
                      ),
                      labelText: 'Business email',
                      labelStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Business email'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownItem(dataMap: dataMap))
          ]),
        ));
  }

  _inviteMember() async {
    var api =
        "https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/invites";

    String token = Global.token;

    var response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authtoken': token,
        },
        body: jsonEncode(dataMap));

    var statusCode = jsonDecode(response.body);

    if (statusCode["error_flag"] == "SUCCESS") {
      snackBar(statusCode['message']);
    } else {
      snackBar(statusCode['message']);
    }

    return response.body;
  }

  snackBar(String statusCode) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(statusCode),
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
