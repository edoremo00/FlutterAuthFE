import 'package:authapi/models/customermodel.dart';
import 'package:authapi/screens/customerscreen.dart';
import 'package:authapi/services/customerservice.dart';
import 'package:authapi/utils/snackbar.dart';
import 'package:authapi/widgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class editcustomerscreen extends StatefulWidget {
  final Customermodel toupdate;
  final Customerservice _customerservice = Customerservice();
  editcustomerscreen({Key? key, required this.toupdate}) : super(key: key);

  @override
  _editcustomerscreenState createState() => _editcustomerscreenState();
}

class _editcustomerscreenState extends State<editcustomerscreen> {
  Customermodel newone = Customermodel();
  bool updatinguserinfo = false;
  bool cameraselected = false;
  final ImagePicker _picker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  late TextEditingController namecontroller;
  late TextEditingController usernamecontroller;
  late TextEditingController surnamecontroller;
  late TextEditingController emailcontroller;
  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController(text: widget.toupdate.name);
    usernamecontroller = TextEditingController(text: widget.toupdate.username);
    surnamecontroller = TextEditingController(text: widget.toupdate.surname);
    emailcontroller = TextEditingController(text: widget.toupdate.email);
  }

  @override
  void dispose() {
    namecontroller.dispose();
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
            onPressed: () async {
              int valueschanged = userchangedvalues();
              if (valueschanged == 0) {
                Utils.showsnackbar(context, 'please modify at least one field');
              }
              copyoldifnull(newone);
              if (_formkey.currentState?.validate() ?? false) {
                setState(() {
                  updatinguserinfo = true;
                });
                bool updateresponse = await widget._customerservice
                    .UpdateCustomer(model: newone)
                    .whenComplete(
                      () => setState(() {
                        updatinguserinfo = false;
                      }),
                    );
                if (updateresponse) {
                  Utils.showsnackbar(
                      context, '${newone.username} updated successfully');
                  await Future.delayed(const Duration(seconds: 3)).then(
                      (value) => ScaffoldMessenger.of(context)
                          .removeCurrentSnackBar());
                  Navigator.pop(context, newone);
                } else {
                  Utils.showsnackbar(
                    context,
                    'an error occured while updating',
                    backrgoundcolor: Colors.red,
                    icon: Icons.error,
                    iconcolor: Colors.black,
                  );
                }
              } else {
                return;
              }
            },
            child: updatinguserinfo
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
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
                            bool? uploadchoice = await bottomsheet(context);
                            if (uploadchoice != null) {
                              XFile? selectedpicture = await _picker.pickImage(
                                source: uploadchoice
                                    ? ImageSource.camera
                                    : ImageSource.gallery,
                              );
                              if (selectedpicture != null) {
                                if (validatefileextension(selectedpicture)) {
                                  copyoldifnull(newone);
                                  StreamedResponse respnse = await widget
                                      ._customerservice
                                      .Uploadprofilepicture(
                                          file: selectedpicture,
                                          username: newone.username!);
                                  if (respnse.reasonPhrase == 'OK') {
                                    String newimageurl =
                                        await respnse.stream.bytesToString();
                                    setState(() {
                                      //aggiorna la UI in pagina corrente
                                      widget.toupdate.imagelink = newimageurl;
                                      newone.imagelink = newimageurl;
                                    });
                                    Navigator.of(context).pop(newone);
                                    //passo il nuovo valore alla pagina precedente che aggiornerà anche lei la UI
                                  }
                                  //CHIAMATA API
                                } else {
                                  return; //file non valido
                                }
                              } else {
                                return;
                              }
                            } else {
                              return;
                            }
                          },
                        ),
                        image: widget.toupdate.imagelink == "" ||
                                widget.toupdate.imagelink == null
                            ? const NetworkImage(
                                'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png',
                              )
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
                  bool? uploadphotochoice = await bottomsheet(context);
                  if (uploadphotochoice != null) {
                    XFile? chosenpicture = await _picker.pickImage(
                      source: uploadphotochoice
                          ? ImageSource.camera
                          : ImageSource.gallery,
                    );
                    if (chosenpicture != null) {
                      if (validatefileextension(chosenpicture)) {
                        //chiamata api
                        copyoldifnull(newone);
                        StreamedResponse respnse = await widget._customerservice
                            .Uploadprofilepicture(
                                file: chosenpicture,
                                username: newone.username!);
                        if (respnse.reasonPhrase == 'OK') {
                          String newimageurl =
                              await respnse.stream.bytesToString();
                          setState(() {
                            widget.toupdate.imagelink = newimageurl;
                            newone.imagelink = newimageurl;
                          });
                          Navigator.of(context).pop(newone);
                          //passo il nuovo valore alla pagina precedente che aggiornerà anche lei la UI
                        }
                      } else {
                        return; //file non valido
                      }
                    } else {
                      return; //file non selezionato
                    }
                  } else {
                    return;
                  }
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
              onchanged: (username) {
                newone.username = usernamecontroller.text;
              },
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
              onchanged: (surname) {
                newone.surname = surnamecontroller.text;
              },
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
              onchanged: (name) {
                newone.name = namecontroller.text;
              },
              labeltext: 'Name',
              controller: namecontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) {
                if (name!.isEmpty) {
                  return 'il campo name non può essere vuoto';
                } else if (name.startsWith(RegExp('[0-9]'))) {
                  return 'name non può cominciare con numeri';
                } else if (name.contains(' ')) {
                  return 'name non può contenere spazi';
                } else {
                  return null;
                }
              },
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

  Future<bool?> bottomsheet(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Scatta nuova'),
                onTap: () {
                  cameraselected = true;
                  Navigator.pop(context, cameraselected);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Scegli esistente'),
                onTap: () {
                  cameraselected = false;
                  Navigator.pop(context, cameraselected);
                },
              ),
              widget.toupdate.imagelink != null
                  ? ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text(
                        'Rimuovi foto profilo',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () async {
                        bool deleteprofileresponse = await Customerservice()
                            .Deleteprofilepicture(
                                username: usernamecontroller.text);
                        if (deleteprofileresponse) {
                          setState(() {
                            newone.imagelink = null;
                            widget.toupdate.imagelink = null;
                          });
                          Navigator.of(context)
                              .pop(); //chiudo popup. nota non posso passare indietro un valore in quanto sopra aspetto la chiusura del popup ed in base ad essa
                          //scelgo la fotocamera o la galleria quindi mi limito a chiudere il popup e navigare alla pagina customerscreen dove passo i nuovi dati
                          await Future.delayed(const Duration(seconds: 2));
                          //delay di due secondi e poi faccio navigazione
                          Navigator.of(context).pop(widget
                              .toupdate); //navigazione a pagina customerscreen
                        }
                      }, //chiamata api che fa rimozione foto se va a buon fine allora faccio anche io il set state
                    )
                  : Container()
            ],
          );
        });
  }

  int userchangedvalues() {
    int fieldschanged = 0;
    //check per evitare di fare chiamata http se valori form non sono modificati. provvisoria fino a quando non trovero modo di accedere direttamente al form
    if (widget.toupdate.username?.toLowerCase() !=
        usernamecontroller.text.toLowerCase().replaceAll(' ', '')) {
      fieldschanged += 1;
    } else if (widget.toupdate.surname?.toLowerCase() !=
        surnamecontroller.text.toLowerCase().replaceAll(' ', '')) {
      fieldschanged += 1;
    } else if (widget.toupdate.name?.toLowerCase() !=
        namecontroller.text.toLowerCase().replaceAll(' ', '')) {
      fieldschanged += 1;
    }
    return fieldschanged;
  }

  Customermodel copyoldifnull(Customermodel newone) {
    //oggetto che mi arriva da pagina precedente è to update. lo uso per fare controlli per vedere se sono cambiati valori
    //nell'onchanged cambio valori di to update con valori controller usando un nuovo oggetto. i valori che non sono cambiati sono null e quindi i valori del nuovo oggetto sono
    //quelli dell'oggetto precedente
    //?? e per fare check se è null. ??= invece controlla se è null e fa assegnazione
    newone.email ??= widget.toupdate.email;
    newone.id ??= widget.toupdate.id;
    newone.imagelink ??= widget.toupdate.imagelink;
    newone.events ??= widget.toupdate.events;
    newone.filename ??= widget.toupdate.filename;
    newone.email ??= widget.toupdate.email;
    newone.events ??= widget.toupdate.events;
    newone.isdeleted ??= widget.toupdate.isdeleted;
    newone.participations ??= widget.toupdate.participations;
    newone.participations ??= widget.toupdate.participations;
    newone.name ??= widget.toupdate.name;
    newone.subscribedtonewsletter ??= widget.toupdate.subscribedtonewsletter;
    newone.surname ??= widget.toupdate.surname;
    newone.username ??= widget.toupdate.username;

    return newone;
  }

  bool validatefileextension(XFile filetovalidate) {
    List<String> acceptedextensions = ['.jpg', '.png', '.jpeg'];
    if (!acceptedextensions.contains(extension(filetovalidate.name))) {
      return false; //file in formato non valido
    } else {
      return true;
    }
  }
}
