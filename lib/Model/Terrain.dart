
class Terrain {
  final String? id;
  final String? complexe;
  final String? typeSport;
  final String? picture;
  final String? name;
  final String? location;
  final double? rating;


  Terrain(this.id, this.complexe, this.typeSport, this.picture,this.name,this.location,this.rating);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'complexe': complexe,
      'typeSport': typeSport,
      'picture': picture,
      'name': name,
      'location': location,
      'rating': rating
    };
  }
  factory Terrain.fromJson(dynamic json) {
    return Terrain(json['_id'] as String?, json['complexe'] as String?, json['typeSport'] as String?,json['picture'] as String?, json['name'] as String?,json['location'] as String?, json['rating'] as double?);
  }

}