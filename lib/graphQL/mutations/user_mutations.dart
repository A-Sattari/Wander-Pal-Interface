import "package:wander_pal/models/traveler.dart";

class UserMutations {

  static String signUpTraveler(Traveler traveler) {
    return
    """
    mutation {
      singUp(input: {
        user: {
          firstName: ${traveler.firstName}
          lastName: ${traveler.lastName}
          dateOfBirth: ${traveler.dateOfBirth}
          about: ${traveler.about}
        }
      })

      {
        long
      }
    }
    """;
  }
}