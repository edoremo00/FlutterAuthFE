import 'package:authapi/formvalidators/formvalidator.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/widgets/loginform.dart';
import 'package:authapi/services/authservice.dart';
import 'package:flutter/material.dart';

class loginscreen extends StatefulWidget {
  loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  late TextEditingController usernamecontroller;
  late TextEditingController passwordcontroller;
  bool hidepass = true;

  @override
  void initState() {
    usernamecontroller = TextEditingController();
    passwordcontroller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final String _title = "Login";
  Loginmodel model = Loginmodel(username: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      //onWillPop: , magari fare apparire popup che avvisa che i dati saranno persi
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
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(30.0),
                  width: 80,
                  height: 375,
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
                        child: loginform(
                          onchanged: (username) {
                            model.username = username;
                          },
                          labeltext: 'Username',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          prefixicon: Icons.person_outline_rounded,
                          validator: validateusername,
                          controller: usernamecontroller,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              color: Colors.black,
                            ),
                          ),
                          validator: validatepassword,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              enableFeedback: true,
                              minimumSize: const Size.fromHeight(40),
                              maximumSize: const Size.fromHeight(40)),
                          onPressed: usernamecontroller.text.isEmpty ||
                                  passwordcontroller.text.isEmpty ||
                                  usernamecontroller.text.isEmpty &&
                                      passwordcontroller.text.isEmpty
                              ? null
                              : () async {
                                  _formkey.currentState!.save();
                                  await login(model);
                                },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      GestureDetector(
                        child: Text(
                          'or register here',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
