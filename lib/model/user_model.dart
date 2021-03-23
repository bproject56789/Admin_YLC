class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool isAdvocate;
  final int timestamp;
  final String photo;
  final bool isSuspended;
  final bool isVerified;
  final Map<String, String> documents;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isAdvocate,
    this.timestamp,
    this.photo,
    this.isSuspended,
    this.isVerified,
    this.documents,
  });
  // factory UserModel.fromSnapshot(DocumentSnapshot snapshot) => UserModel(
  //       id: snapshot.data()['id'],
  //       name: snapshot.data()['name'],
  //       email: snapshot.data()['email'],
  //       phone: snapshot.data()['phone'],
  //       isAdvocate: snapshot.data()['isAdvocate'],
  //       timestamp: snapshot.data()['timestamp'],
  //       photo: snapshot.data()['photo'],
  //       isSuspended: snapshot.data().containsKey('isSuspended')
  //           ? (snapshot.data()['isSuspended'] ?? false)
  //           : false,
  //       isVerified: snapshot.data().containsKey('isVerified')
  //           ? (snapshot.data()['isVerified'] ?? false)
  //           : false,
  //       documents: snapshot.data().containsKey('documents')
  //           ? Map<String, String>.from(snapshot.data()['documents'] ?? {})
  //           : {},
  //     );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      isAdvocate: map['isAdvocate'],
      timestamp: map['timestamp'],
      photo: map['photo'],
      isSuspended: map.containsKey('isSuspended')
          ? (map['isSuspended'] ?? false)
          : false,
      isVerified:
          map.containsKey('isVerified') ? (map['isVerified'] ?? false) : false,
      documents: map.containsKey('documents')
          ? Map<String, String>.from(map['documents'] ?? {})
          : {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isAdvocate': isAdvocate,
      'timestamp': timestamp,
      'photo': photo,
      'isSuspended': isSuspended,
      'isVerified': isVerified,
      'documents': documents,
    };
  }
}
