class GatheringAttendee {
  int travelerId;
  int gatheringId;

  GatheringAttendee(this.travelerId, this.gatheringId);

    GatheringAttendee.fromJson(Map<String, dynamic> json) :
      travelerId = json["travelerId"],
      gatheringId = json["gatheringId"];
}