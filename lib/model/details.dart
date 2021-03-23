// class Details {
//   Details({
//     this.id,
//     this.name,
//     this.photo,
//   });

//   final String id;
//   final String name;
//   final String photo;

//   Details copyWith({
//     String id,
//     String name,
//     String photo,
//   }) =>
//       Details(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         photo: photo ?? this.photo,
//       );

//   factory Details.fromMap(Map<String, dynamic> json) => Details(
//         id: json["id"],
//         name: json["name"],
//         photo: json["photo"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "photo": photo,
//       };
// }
