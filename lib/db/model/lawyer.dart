

class Lawyer {

  final int id;
  final String uuid;
  final String name;
  final String address;
  final String state;
  final String field_of_expertise;
  final String bio;
  final String level;
  final String hours_logged;
  final String phone_no;
  final String email;
  final List areas_of_practise;
  final List service_offered;
  final String profile_picture;
  final String rating;
  final String ranking;

  Lawyer({
    required this.id,
    required this.uuid,
    required this.name,
    required this.address,
    required this.state,
    required this.field_of_expertise,
    required this.bio,
    required this.level,
    required this.hours_logged,
    required this.phone_no,
    required this.email,
    required this.areas_of_practise,
    required this.service_offered,
    required this.profile_picture,
    required this.rating,
    required this.ranking});

  static List<Lawyer> getLawyersList(List<dynamic> data){
    return data.map((e) => Lawyer.fromMap(e)).toList();
  }


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uuid': this.uuid,
      'name': this.name,
      'address': this.address,
      'state': this.state,
      'field_of_expertise': this.field_of_expertise,
      'bio': this.bio,
      'level': this.level,
      'hours_logged': this.hours_logged,
      'phone_no': this.phone_no,
      'email': this.email,
      'areas_of_practise': this.areas_of_practise,
      'service_offered': this.service_offered,
      'profile_picture': this.profile_picture,
      'rating': this.rating,
      'ranking': this.ranking,
    };
  }

  factory Lawyer.fromMap(Map<String, dynamic> map) {
    return Lawyer(
      id: map['id'] as int,
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      state: map['state'] as String,
      field_of_expertise: map['field_of_expertise'] as String,
      bio: map['bio'] as String,
      level: map['level'] as String,
      hours_logged: map['hours_logged'] as String,
      phone_no: map['phone_no'] as String,
      email: map['email'] as String,
      areas_of_practise: map['areas_of_practise'] as List,
      service_offered: map['service_offered'] as List,
      profile_picture: map['profile_picture'] as String,
      rating: map['rating'] as String,
      ranking: map['ranking'] as String,
    );
  }
}