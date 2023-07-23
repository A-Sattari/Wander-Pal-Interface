import "package:wander_pal/models/discussion_category.dart";

class Discussion {
  int id;
  int authorId;
  DiscussionCategory category;
  String countryCode;
  String city;
  String content;
  late DateTime creationDate;

  Discussion(this.id, this.authorId, this.category, this.countryCode, this.city, this.content) {
    creationDate = DateTime.now();
  }
}