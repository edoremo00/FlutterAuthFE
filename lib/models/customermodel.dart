import 'dart:convert';

class Customermodel {
  String? name;
  String? username;
  String? surname;
  String? email;
  String? id;
  List<Events>? events;
  List<Participation>? participations;
  bool? subscribedtonewsletter;
  bool? isdeleted;
  String? imagelink;
  String? profilepicisdeleted;
  String? filename;
  Customermodel(
      {this.name,
      this.username,
      this.surname,
      this.email,
      this.id,
      this.events,
      this.participations,
      this.subscribedtonewsletter,
      this.isdeleted,
      this.filename,
      this.imagelink,
      this.profilepicisdeleted});

  Map<String, dynamic> toMap() {
    //tojson
    return {
      'name': name,
      'username': username,
      'surname': surname,
      'email': email,
      'id': id,
      'events': events?.map((x) => x.toMap()).toList(),
      'participations': participations?.map((x) => x.toMap()).toList(),
      'subscribedtonewsletter': subscribedtonewsletter,
      'isdeleted': isdeleted,
      'fileName': filename,
      'imageLink': imagelink,
      'profilePicIsDeleted': profilepicisdeleted
    };
  }

  factory Customermodel.fromMap(Map<String, dynamic> map) {
    //fromjson
    return Customermodel(
      name: map['name'],
      username: map['username'],
      surname: map['surname'],
      email: map['email'],
      id: map['id'],
      events: map['events'] != null
          ? List<Events>.from(map['events']?.map((x) => Events.fromMap(x)))
          : null,
      participations: map['participations'] != null
          ? List<Participation>.from(
              map['participations']?.map((x) => Participation.fromMap(x)))
          : null,
      subscribedtonewsletter: map['subscribedtonewsletter'],
      isdeleted: map['isdeleted'],
      filename: map['fileName'],
      imagelink: map['imageLink'],
      profilepicisdeleted: map['profilePicIsDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customermodel.fromJson(String source) =>
      Customermodel.fromMap(json.decode(source));
}

class Events {
  String? eventname;
  int? eventid;
  int? maxpartecipanti;
  int? postidisponibili;
  List<Customermodel>? customers;
  List<Participation>? participations;
  Events({
    this.eventname,
    this.eventid,
    this.maxpartecipanti,
    this.postidisponibili,
    this.customers,
    this.participations,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventname': eventname,
      'eventid': eventid,
      'maxpartecipanti': maxpartecipanti,
      'postidisponibili': postidisponibili,
      'customers': customers?.map((x) => x.toMap()).toList(),
      'participations': participations?.map((x) => x.toMap()).toList(),
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      eventname: map['eventname'],
      eventid: map['eventid']?.toInt(),
      maxpartecipanti: map['maxpartecipanti']?.toInt(),
      postidisponibili: map['postidisponibili']?.toInt(),
      customers: map['customers'] != null
          ? List<Customermodel>.from(
              map['customers']?.map((x) => Customermodel.fromMap(x)))
          : null,
      participations: map['participations'] != null
          ? List<Participation>.from(
              map['participations']?.map((x) => Participation.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));
}

class Participation {
  int? participationid;
  String? customerid;
  int? eventid;
  bool? deletedparticipation;
  bool? subscribeduser;
  Events? events;
  Participation({
    this.participationid,
    this.customerid,
    this.eventid,
    this.deletedparticipation,
    this.subscribeduser,
    this.events,
  });

  Map<String, dynamic> toMap() {
    return {
      'participationid': participationid,
      'customerid': customerid,
      'eventid': eventid,
      'deletedparticipation': deletedparticipation,
      'subscribeduser': subscribeduser,
      'events': events?.toMap(),
    };
  }

  factory Participation.fromMap(Map<String, dynamic> map) {
    return Participation(
      participationid: map['participationid']?.toInt(),
      customerid: map['customerid'],
      eventid: map['eventid']?.toInt(),
      deletedparticipation: map['deletedparticipation'],
      subscribeduser: map['subscribeduser'],
      events: map['events'] != null ? Events.fromMap(map['events']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Participation.fromJson(String source) =>
      Participation.fromMap(json.decode(source));
}
