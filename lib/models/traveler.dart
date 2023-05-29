class Traveler {
  int id;
  Uri? profileUri;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String about;
  List<String> languages;
  String? origin;
  String? currentCity;
  String? currentCountry;

  Traveler(this.id, this.firstName, this.lastName, this.dateOfBirth, this.about, this.languages);

  Traveler.fromJson(Map<String, dynamic> json) :
    id = json["id"],
    profileUri = json["profileUri"],
    firstName = json["firstName"],
    lastName = json["lastName"],
    dateOfBirth = DateTime.parse(json["dateOfBirth"]),
    about = json["about"],
    languages = List<String>.from(json["languages"]);
}