import "../models/gathering_search.dart";

class GatheringQueries {
  
  static String getAll() {
    return """
    query GetGatherings(\$$GatheringSearch: GatheringSearchInput!) {
      gatherings(searchArg: \$$GatheringSearch) {
        id
        title
        description
        startDateTime
        endDateTime
        location
        isApprovalNeeded
      }
    }
    """;
  }

  static String getAttendees(int gatheringId) {
    return
    """
    query GetAttendees {
      gatheringAttendees(gatheringId: $gatheringId) {
        id
        firstName
        lastName
        about
        dateOfBirth
        languages
      }
    }
    """;
  }
}