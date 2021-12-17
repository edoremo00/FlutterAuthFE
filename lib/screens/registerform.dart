import 'package:authapi/formvalidators/formvalidator.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/widgets/loginform.dart';
import 'package:authapi/services/authservice.dart';
import 'package:flutter/material.dart';

class Registerform extends StatefulWidget {
  const Registerform({Key? key}) : super(key: key);

  @override
  _RegisterformState createState() => _RegisterformState();
}

class _RegisterformState extends State<Registerform> {
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
                onchanged: (username) {
                  reg.username = username;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                prefixicon: Icons.person_outline_rounded,
                controller: usernamecontroller,
                labeltext: 'username',
                validator: validateusername,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: loginform(
                onchanged: (surname) {
                  reg.surname = surname;
                },
                controller: surnamecontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validatesurname,
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
                validator: validateemail,
                keyboardtype: TextInputType.emailAddress,
                prefixicon: Icons.email_outlined,
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
                validator: validatepassword,
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
                    return 'provide a confirmpassword';
                  } else if (confirmpassword.contains(' ')) {
                    return "confirmpassword can't contain spaces";
                  } else if (confirmpassword.toLowerCase() !=
                      passwordcontroller.text.toLowerCase()) {
                    return 'password and confirmpassword are not equal';
                  } else if (validatepasswordstructure(confirmpassword) ==
                      false) {
                    return 'confirmpassword should at least have 8 characters';
                  } else {
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
                onPressed: _formkey.currentState?.validate() ?? false
                    ? () async {
                        setState(() {});
                        bool registerresult = await register(reg);
                        if (registerresult) {
                          Navigator.of(context).pop([
                            reg.username,
                            reg.password
                          ]); //se mi sono registrato correttamente fare redirect su pagina login dove passerò username e password per precompilare campi form login
                        } else {
                          _formkey.currentState!.reset();
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
}
