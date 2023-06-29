class Gathering {
  int id;
  String title;
  String description;
  String location;
  bool approvalNeeded;
  DateTime start;
  DateTime? end;

  Gathering(this.id, this.title, this.description, this.location, this.approvalNeeded, this.start);  

  Gathering.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      title = json["title"],
      description = json["description"],
      location = json["location"],
      approvalNeeded = json["isApprovalNeeded"],
      start = DateTime.parse(json["start"]),
      end = DateTime.parse(json["end"]);
}