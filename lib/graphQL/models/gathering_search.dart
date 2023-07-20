class GatheringSearch {
  int? creatorId;
  DateTime? start;
  DateTime? end;

  GatheringSearch({this.creatorId, this.start, this.end});

  Map<String, dynamic> toJson() => {
    "$GatheringSearch": {
      "creatorId": creatorId,
      "startDate": start,
      "endDate": end
    }
  };
}