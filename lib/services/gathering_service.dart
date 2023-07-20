import "package:wander_pal/models/traveler.dart";
import "package:wander_pal/models/gathering.dart";
import "package:wander_pal/services/api_client.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wander_pal/graphQL/models/gathering_search.dart";
import "package:wander_pal/graphQL/queries/gathering_queries.dart";

class GatheringService {

  late final APIClient apiClient;

  GatheringService({required this.apiClient});

  Future<List<Gathering>> getGatherings() async {

    String query = GatheringQueries.getAll();
    var querySearch = GatheringSearch(creatorId: 5).toJson();
    var gatheringsJson = await apiClient.queryGraphQL(documentQuery: query, vars: querySearch);

    List<Gathering> gatherings = List.empty(growable: true);
    for (var g in gatheringsJson) {
      gatherings.add(Gathering.fromJson(g));
    }

    return gatherings;
  }

  Future<List<Traveler>> getAttendees(int gatheringId) async {
    
    String query = GatheringQueries.getAttendees(gatheringId);
    var attendeesJson = await apiClient.queryGraphQL(documentQuery: query);
    
    List<Traveler> attendees = List.empty(growable: true);
    for (var t in attendeesJson) {
      attendees.add(Traveler.fromJson(t));
    }

    return attendees;
  }
}

final gatheringServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GatheringService(apiClient: apiClient);
});