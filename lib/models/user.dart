import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String? token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Serializetion : Convert User Object to JSON
  //Map: A Map is a collection of key-value pairs.
  //Why: Coverting to a map is an intermediate step that makes it easier to serialize the object to JSON.
  //the object to formates like json for storage or transmission.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //Serialization : Convert Map to a Json String
  //this method directly encodes the data from the Map into a Json String

  //json.encode() function converts a dart object (such as map or list)
  //into a JSON string representation. make it suitable for communication
  //over the different platfroms.
  String toJson() => json.encode(toMap());

  //Deserializetion : convert a map to user object
  //purpose - mainpulation and user : once the data is converted a to a user object
  //it can be easily mainpulated and used in the application. for example
  //we can access the user's email address, name, etc. ui . or we might
  //want to save the data locally.

  //the factory constructor takes a map (usually obtained from a json object)
  // and convert it into a user object if a field is not presented in the,
  // it degaults to an empty String

  //fromMap : this constructor takes a map and convert it into a user object
  //. its usefull when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      password: map['password'] as String? ?? '',
      token: map['token'] as String? ?? '',
    );
  }

  //fromJson : this constructor takes a json string and convert it into Map<String, dynamic>
  //and the uses fromMap to convert it into a user object.
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
