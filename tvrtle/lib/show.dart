class Show {
  final int id;
  final String name;
  // final String image;

  Show({this.id, this.name}); // this.image});

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      name: json['name'],
      // image: json['image'],
    );
  }
}

// struct APIShow: Decodable {
//     var name: String
//     var id: Int
//     //    var summary: String?
//     var image: ApiImages?
//     var _embedded: Embedded?
//     var episodesCount: Int?
//     struct ApiImages: Decodable {
//         var medium: String?
//         var original: String?
//     }
//     struct Embedded: Decodable {
//         var episodes: [Show.Episode]?
//     }
//     struct Episode: Decodable {
//         var id: Int
//         var name: String
//         var season: Int
//         var number: Int
//         //        var Image: ApiImages?
//     }

// }
