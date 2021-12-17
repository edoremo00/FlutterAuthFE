import 'package:authapi/formvalidators/formvalidator.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/registerform.dart';
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
  Registermodel reg = Registermodel();

  @override
  void initState() {
    usernamecontroller = TextEditingController(); //text: reg.username ?? ''
    passwordcontroller = TextEditingController(); //text: reg.password ?? ''

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
                              onchanged: (username) {
                                model.username = username;
                              },
                              labeltext: 'Username',
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              prefixicon: Icons.person_outline_rounded,
                              validator: validateusername,
                              controller: usernamecontroller,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            onPressed:
                                _formkey.currentState?.validate() ?? false
                                    ? () async {
                                        setState(() {});
                                        _formkey.currentState!.save();
                                        await login(model);
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registerform(),
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
      ),
    );
  }
}
