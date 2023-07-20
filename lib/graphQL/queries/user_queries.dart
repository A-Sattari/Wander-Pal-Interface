class UserQueries {
  
  static String getAccount() {
    return
    """
    query GetThisAccount {
      user {
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