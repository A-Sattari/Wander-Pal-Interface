import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:wander_pal/services/api_client.dart";
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";

class AccountService {

  Future<void> setupAccount(UserCredential credential) async {
    final authUser = credential.user; //TODO: Throw exception if User is null
    final idpToken = await authUser!.getIdToken(); //TODO: Store the token locally

    final apiClient = APIClient();
    String userQuery =
    """
    query {
      user {
        id
        firstName
        lastName
        about
        languages
      }
    }
    """;

    final user = await apiClient.queryGraphQL(query: userQuery, token: idpToken);
    if (user == null) { // Create user
      String userMutation = 
      """
      mutation {
        singUp(input: {
          user: {
            firstName: "Nono"
            lastName: "Bomo"
            dateOfBirth: "2000-02-12"
            about: "Hola"
          }
        })

        {
          long
        }
      }
      """;
      var r = apiClient.mutateGraphQL(query: userMutation, token: idpToken);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
// https://firebase.google.com/docs/auth/flutter/federated-auth