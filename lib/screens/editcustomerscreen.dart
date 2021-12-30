import 'package:authapi/models/customermodel.dart';
import 'package:authapi/widgets/loginform.dart';
import 'package:flutter/material.dart';

class editcustomerscreen extends StatefulWidget {
  final Customermodel toupdate;
  const editcustomerscreen({Key? key, required this.toupdate})
      : super(key: key);

  @override
  _editcustomerscreenState createState() => _editcustomerscreenState();
}

class _editcustomerscreenState extends State<editcustomerscreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController usernamecontroller;
  late TextEditingController surnamecontroller;
  late TextEditingController emailcontroller;
  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController(text: widget.toupdate.username);
    surnamecontroller = TextEditingController(text: widget.toupdate.surname);
    emailcontroller = TextEditingController(text: widget.toupdate.email);
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    surnamecontroller.dispose();
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Salva',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        title: const Text(
          'Modifica utente',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        width: 80,
                        height: 80,
                        child: InkWell(
                          onTap: () async {
                            await bottomsheet(context);
                          },
                        ),
                        image: widget.toupdate.imagelink == "" ||
                                widget.toupdate.imagelink == null
                            ? const NetworkImage(
                                'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png')
                            : NetworkImage(
                                widget.toupdate.imagelink!,
                              ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await bottomsheet(context);
                },
                child: const Text(
                  'Cambia immagine del profilo',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            loginform(
              validator: (username) {
                if (username!.isEmpty) {
                  return 'il campo username non può essere vuoto';
                } else if (username.startsWith(RegExp('[0-9]'))) {
                  return 'username non può cominciare con numeri';
                } else if (username.contains(' ')) {
                  return 'username non può contenere spazi';
                } else {
                  return null;
                }
              },
              controller: usernamecontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labeltext: 'Username',
            ),
            const SizedBox(
              height: 16,
            ),
            loginform(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (surname) {
                if (surname!.isEmpty) {
                  return 'il campo surname non può essere vuoto';
                } else if (surname.startsWith(RegExp('[0-9]'))) {
                  return 'surname non può cominciare con numeri';
                } else if (surname.contains(' ')) {
                  return 'surname non può contenere spazi';
                } else {
                  return null;
                }
              },
              controller: surnamecontroller,
              labeltext: 'surname',
            ),
            const SizedBox(
              height: 16,
            ),
            loginform(
              readonly: true,
              controller: emailcontroller,
              labeltext: 'Email',
              keyboardtype: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Scatta nuova'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Scegli esistente'),
                onTap: () {},
              ),
              widget.toupdate.imagelink != null
                  ? ListTile(
                      leading: Icon(Icons.delete),
                      title: const Text(
                        'Rimuovi foto profilo',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap:
                          () {}, //chiamata api che fa rimozione foto se va a buon fine allora faccio anche io il set state
                    )
                  : Container()
            ],
          );
        });
  }
}
