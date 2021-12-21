// ignore_for_file: prefer_const_constructors

import 'package:authapi/formvalidators/formvalidator.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/widgets/loginform.dart';
import 'package:authapi/services/authservice.dart';
import 'package:flutter/material.dart';

class Registerformscreen extends StatefulWidget {
  const Registerformscreen({Key? key}) : super(key: key);

  @override
  _RegisterformscreenState createState() => _RegisterformscreenState();
}

class _RegisterformscreenState extends State<Registerformscreen> {
  late TextEditingController usernamecontroller;
  late TextEditingController surnamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController passwordcontroller;
  late TextEditingController confirmpasswordcontroller;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    surnamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    surnamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  Registermodel reg = Registermodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                maxlength: 12,
                onchanged: (username) {
                  reg.username = username;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefixicon: Icon(Icons.person_outline_rounded),
                controller: usernamecontroller,
                labeltext: 'username',
                validator: (username) {
                  if (username!.isEmpty) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'username is required';
                  } else if (username.startsWith(RegExp('[0-9]'))) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "username can't begin with numbers";
                  } else if (username.contains(' ')) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "username can't contain spaces";
                  } else {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                maxlength: 16,
                onchanged: (surname) {
                  reg.surname = surname;
                },
                controller: surnamecontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (surname) {
                  if (surname!.isEmpty) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'surname is required';
                  } else if (surname.startsWith(RegExp('[0-9]'))) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "surname can't begin with numbers";
                  } else if (surname.contains(' ')) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "surname can't contain spaces";
                  } else {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return null;
                  }
                },
                labeltext: 'surname',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                onchanged: (email) {
                  reg.email = email;
                },
                controller: emailcontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labeltext: 'email',
                validator: (email) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{;|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regExp = RegExp(pattern);
                  if (regExp.hasMatch(email!)) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return null;
                  } else {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'not a valid email';
                  }
                },
                keyboardtype: TextInputType.emailAddress,
                prefixicon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                onchanged: (password) {
                  reg.password = password;
                },
                controller: passwordcontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hidepassword: true,
                validator: (password) {
                  if (password!.isEmpty) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'provide a password';
                  } else if (password.contains(' ')) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "password can't contain whitespaces";
                  } else if (password.length < 8) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "password should at least have 8 characters";
                  } else if (validatepasswordstructure(password) == false) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "password doesn't match requisites";
                  } else {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return null;
                  }
                },
                helpertext:
                    'password should at least have: 1 uppercase char, 1 number,1 special char,numbers and a minimum length of 8',
                labeltext: 'password',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                onchanged: (confirmpassword) {
                  reg.confirmpassword = confirmpassword;
                },
                controller: confirmpasswordcontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hidepassword: true,
                validator: (confirmpassword) {
                  if (confirmpassword!.isEmpty) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'provide a confirmpassword';
                  } else if (confirmpassword.contains(' ')) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return "confirmpassword can't contain spaces";
                  } else if (confirmpassword.toLowerCase() !=
                      passwordcontroller.text.toLowerCase()) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'password and confirmpassword are not equal';
                  } else if (validatepasswordstructure(confirmpassword) ==
                      false) {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return 'confirmpassword should at least have 8 characters';
                  } else {
                    Future.delayed(Duration.zero)
                        .then((value) => setState(() {}));
                    return null;
                  }
                },
                labeltext: 'confirmpassword',
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(30),
              child: ElevatedButton.icon(
                onPressed: _formkey.currentState?.validate() == true
                    ? () async {
                        bool registerresult = await register(reg);
                        if (registerresult) {
                          showregistersnackbar(
                            context: context,
                            coloresfondo: Colors.green,
                            icona: Icons.info,
                            testo: 'Registered successfully!',
                          );
                          await Future.delayed(Duration(seconds: 3)).then(
                            (value) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              Navigator.of(context).pop(reg);
                            },
                          );

                          //se mi sono registrato correttamente fare redirect su pagina login dove passerò username e password per precompilare campi form login
                        } else {
                          showregistersnackbar(
                            context: context,
                            coloresfondo: Colors.red,
                            icona: Icons.warning,
                            testo: 'problem in register',
                          );
                          //CASO IN CUI REGISTRAZIONE NON VA A BUON FINE RESETTO I CAMPI PER ORA POI FARE UNO SNACKBAR PER AVVISARE UTENTE
                          setState(() {
                            //non posso usare formkey.currentstate.save. poichè ho hai initial value o hai text
                            usernamecontroller.clear();
                            surnamecontroller.clear();
                            emailcontroller.clear();
                            passwordcontroller.clear();
                            confirmpasswordcontroller.clear();
                            //vengono triggerati i validator per qualche motivo
                          });
                        }
                      }
                    : null,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Registrati',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showregistersnackbar(
      {required BuildContext context,
      IconData? icona,
      String? testo,
      Color? coloresfondo}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: coloresfondo,
        content: Row(
          children: [
            Icon(
              icona,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(testo!)
          ],
        ),
      ),
    );
  }
}
