import 'package:flutter/material.dart';

import 'package:authapi/authutils/tokenstorage.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/models/customermodel.dart';
import 'package:authapi/screens/loginscreen.dart';
import 'package:authapi/services/customerservice.dart';

class Landingscreen extends StatefulWidget {
  Loginmodel? model;
  Landingscreen({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  _LandingscreenState createState() => _LandingscreenState();
}

class _LandingscreenState extends State<Landingscreen> {
  Customermodel? loggedcustomer = Customermodel();
  late Future<Customermodel?> customermodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customermodel = getloggeduserprofilepic(username: widget.model!.username!);
    /*WidgetsBinding.instance!.addPostFrameCallback((_) async {
      loggedcustomer =
          await getloggeduserprofilepic(username: widget.model!.username!);
      if (loggedcustomer != null) {
        setState(() {});
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homepage',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          /*CircleAvatar(
            backgroundImage: NetworkImage(
              loggedcustomer?.imagelink == "" ||
                      loggedcustomer?.imagelink == null
                  ? 'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png'
                  : loggedcustomer!.imagelink!,
            ),
            //backgroundColor: Colors.orange,
            //ci sara immagine profilo utente dentro
          ),*/
          FutureBuilder(
            builder: (context, AsyncSnapshot<Customermodel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                //lascio vuoto senno vedi per pochissimo il widget qui dentro
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const CircleAvatar(
                  backgroundColor: Colors.black,
                );
              }
              if (snapshot.hasData) {
                Customermodel? logged = snapshot.data;
                return CircleAvatar(
                  backgroundImage: NetworkImage(logged!.imagelink!),
                );
              }
              if (snapshot.hasError) {
                return const CircleAvatar(
                  backgroundColor: Colors.red,
                );
              }
              return const CircleAvatar();
            },
            future: customermodel,
          ),
          PopupMenuButton<int>(
            onSelected: (value) => onselected(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onselected(BuildContext context, int value) async {
    if (value == 0) {
      await Tokenstorage.removetokenfromstorage('token').then(
        (value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => loginscreen(),
          ),
        ),
      );
    }
  }

  Future<Customermodel?> getloggeduserprofilepic(
      {required String username}) async {
    try {
      loggedcustomer = await Getall().then((value) => value
          .where(
            (element) =>
                element.username?.toLowerCase() == username.toLowerCase(),
          )
          .single);
      if (loggedcustomer != null) {
        return loggedcustomer;
      }
    } catch (e) {
      return null;
    }
  }
}