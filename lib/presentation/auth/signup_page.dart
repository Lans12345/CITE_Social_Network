import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/auth/signup2_page.dart';
import 'package:monetization_system/presentation/widgets/button_widget.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var dropDownValue = 1;

  var productCategory = 'Multimedia Systems';

  late String fullname;
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: TextRegular(
                              text: 'Social Network',
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        TextBold(
                            text: 'CITE Department',
                            fontSize: 26,
                            color: Colors.white),
                      ],
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextBold(
                      text: 'Register your Account',
                      fontSize: 24,
                      color: Colors.grey),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_nput) {
                        fullname = _nput;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Fullname',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_nput) {
                        email = _nput;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        child: DropdownButton(
                          underline: Container(color: Colors.transparent),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          value: dropDownValue,
                          items: [
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Multimedia Systems";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Multimedia Systems",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Appliances";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Appliances",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Clothes";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Clothes",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 3,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = int.parse(value.toString());
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage2()));
                      },
                      text: 'Continue'),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
