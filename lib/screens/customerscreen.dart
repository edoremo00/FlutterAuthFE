import 'package:authapi/models/customermodel.dart';
import 'package:authapi/screens/editcustomerscreen.dart';
import 'package:authapi/services/customerservice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Customerscreen extends StatefulWidget {
  final Customerservice _customerservice = Customerservice();
  Customerscreen({Key? key}) : super(key: key);

  @override
  _CustomerscreenState createState() => _CustomerscreenState();
}

class _CustomerscreenState extends State<Customerscreen> {
  int index = 0;
  late Future<List<Customermodel>?> getallcustomers;
  String searchstring = "";

  @override
  void initState() {
    super.initState();
    /*searchsring.isEmpty || searchsring.contains(' ')
        ? getallcustomers = widget._customerservice.Getall()
        : getallcustomers =
            widget._customerservice.Getfilteredcustomers(searchsring);*/
    getallcustomers = widget._customerservice.Getall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'People',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchstring = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'search user',
              suffixIcon: searchstring.isEmpty
                  ? const Icon(Icons.search)
                  : IconButton(
                      icon: const Icon(Icons.highlight_off),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: searchstring.isEmpty
                ? getallcustomers
                : widget._customerservice.Getfilteredcustomers(searchstring),
            builder: (context, AsyncSnapshot<List<Customermodel>?> snapshot) {
              if (snapshot.hasData) {
                List<Customermodel>? allcustomers = snapshot.data;
                if (allcustomers!.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      Text('No results found')
                    ],
                  );
                }
                return Scrollbar(
                  thickness: 8,
                  radius: const Radius.circular(8),
                  showTrackOnHover: true,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    }, //fa ricostruire futurebuilder avendo così dati aggiornati
                    //_pullrefresh,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: Key(allcustomers[index].id!),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                label: 'Modifica',
                                autoClose: true,
                                onPressed: (context) async {
                                  //navigazione a pagina modifica passando allcustomers[index]
                                  final updateresult =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute<Customermodel>(
                                      builder: (BuildContext context) =>
                                          Editcustomerscreen(
                                        toupdate: allcustomers[index],
                                      ),
                                    ),
                                  );
                                  if (updateresult != null) {
                                    setState(() {
                                      allcustomers[index] = updateresult;
                                    });
                                  }
                                },
                                backgroundColor: Colors.orange,
                                icon: Icons.edit,
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                label: 'Elimina',
                                onPressed: (context) async {
                                  bool deleteresponse = await widget
                                      ._customerservice
                                      .Deletecustomer(
                                    idcustomer: allcustomers[index].id!,
                                  );
                                  if (deleteresponse) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 3),
                                        content: Text(
                                          '${allcustomers[index].username!} eliminato',
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      allcustomers.removeAt(index);
                                    });
                                  }
                                },
                                autoClose: true,
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Hero(
                              tag: allcustomers[index].id.toString(),
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.contain,
                                imageUrl: allcustomers[index].imagelink == "" ||
                                        allcustomers[index].imagelink == null
                                    ? 'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png'
                                    : allcustomers[index].imagelink!,
                                imageBuilder: (context, imageProvider) {
                                  return CircleAvatar(
                                    backgroundImage: imageProvider,
                                  );
                                },
                              ),
                            ),
                            title: Text(allcustomers[index].username!),
                            subtitle: Text(allcustomers[index].email!),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () async {
                              final updateresult =
                                  await Navigator.of(context).push(
                                MaterialPageRoute<Customermodel>(
                                  builder: (BuildContext context) =>
                                      Editcustomerscreen(
                                    toupdate: allcustomers[index],
                                  ),
                                ),
                              );
                              if (updateresult != null) {
                                setState(() {
                                  allcustomers[index] = updateresult;
                                });
                              }
                            }, //NAVIGAZIONE A PAGINA DETTAGLIO
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          indent: 20,
                          endIndent: 20,
                        );
                      },
                      itemCount: allcustomers.length,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return MaterialBanner(
                  content: Row(
                    children: const [
                      Icon(Icons.warning),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Si è verificato un problema')
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text('CHIUDI'),
                    )
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ]),
    );
  }

  /*_getall() async {
    return _memoizer.runOnce(() async {
      List<Customermodel> allcustomers = await Getall();
      return allcustomers;
    });
  }*/

  /*Future<void> _pullrefresh() async {
    List<Customermodel> allcustomer = await Getall();
    setState(() {
      getallcustomers = Future.value(allcustomer);
    });
  }*/
}
