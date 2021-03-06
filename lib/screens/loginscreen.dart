import 'package:authapi/formvalidators/formvalidator.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/mainpage.dart';
import 'package:authapi/screens/registerformscreen.dart';
import 'package:authapi/services/authservice.dart';
import 'package:authapi/widgets/loginform.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  final Authservice _authservice = Authservice();
  Loginscreen({Key? key}) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  late TextEditingController usernamecontroller;
  late TextEditingController passwordcontroller;
  bool hidepass = true;

  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  final _loginformkey = GlobalKey<FormState>();
  final String _title = "Login";
  Loginmodel model = Loginmodel(username: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginformkey,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 52, 156, 225),
                Color.fromARGB(255, 142, 69, 173)
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent, //sennò non vedo il gradiente
          appBar: AppBar(
            title: Text(
              _title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    width: 80,
                    height: 430,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: loginform(
                              maxlength: 32,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: usernamecontroller,
                              validator: (username) {
                                if (username!.isEmpty) {
                                  Future.delayed(Duration.zero)
                                      .then((value) => setState(() {}));
                                  return 'username is required';
                                } else if (username
                                    .startsWith(RegExp('[0-9]'))) {
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
                              onchanged: (username) {
                                model.username = username;
                              },
                              labeltext: 'Username',
                              prefixicon:
                                  const Icon(Icons.person_outline_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: loginform(
                            onchanged: (password) {
                              model.password = password;
                            },
                            hidepassword: hidepass,

                            helpertext:
                                'password should at least have: 1 uppercase char, 1 number,1 special char,numbers and a minimum length of 8',
                            controller: passwordcontroller,
                            labeltext: 'Password',
                            //prefixicon: Icons.password_rounded,
                            suffixicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidepass = !hidepass;
                                });
                              },
                              icon: Icon(
                                hidepass
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
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
                              } else if (validatepasswordstructure(password) ==
                                  false) {
                                Future.delayed(Duration.zero)
                                    .then((value) => setState(() {}));
                                return "password doesn't match requisites";
                              } else {
                                Future.delayed(Duration.zero)
                                    .then((value) => setState(() {}));
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: _loginformkey.currentState?.validate() ??
                                    false
                                ? () async {
                                    _loginformkey.currentState!.save();
                                    bool loginresult =
                                        await widget._authservice.login(model);
                                    if (!loginresult) {
                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(
                                        MaterialBanner(
                                          leading:
                                              const Icon(Icons.warning_rounded),
                                          content: const Text(
                                            'Something went wrong',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                              },
                                              child: const Text(
                                                'DISMISS',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              MainPage(
                                            model: model,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              'or register here',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          onTap: () async {
                            //chiude la tastiera
                            FocusScope.of(context).unfocus();
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registerformscreen(),
                              ),
                            );
                            if (result != null) {
                              result as Registermodel;
                              setState(() {
                                usernamecontroller.text = result.username!;
                                passwordcontroller.text = result.password!;
                                model.username = result.username!;
                                model.password = result.password!;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
