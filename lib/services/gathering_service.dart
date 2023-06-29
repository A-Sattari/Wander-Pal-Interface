import "package:wander_pal/models/traveler.dart";
import "package:wander_pal/services/api_client.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class GatheringService {

  late final APIClient apiClient;

  GatheringService({required this.apiClient});

  Future<List<Traveler>> getAttendees() async {
    String attendeesQuery =
    """
    gatheringAttendees(gatheringId: 4) {
      id
      firstName
      lastName
      about
      dateOfBirth
      languages
    }
    """;
    var attendeesJson = await apiClient.queryGraphQL(query: attendeesQuery);
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