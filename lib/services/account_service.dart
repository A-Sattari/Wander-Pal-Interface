import "package:wander_pal/models/traveler.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:wander_pal/services/api_client.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

final accountServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AccountService(apiClient: apiClient);
});

class AccountService {
  final APIClient apiClient;
  static const String idpTokenKey = "Bearer Token";

  AccountService({required this.apiClient});

  Future<void> setupAccount(UserCredential credential) async {
    final authUser = credential.user; //TODO: Throw exception if User is null
    final idpToken = await authUser!.getIdToken();
    const secureStorage = FlutterSecureStorage();
    secureStorage.write(key: idpTokenKey, value: idpToken);

    String userQuery =
    """
    query {
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

    final travelerJson = await apiClient.queryGraphQL(query: userQuery, token: idpToken);
    if (travelerJson == null) { // Create user
      String travelerMutation = 
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
      final t = apiClient.mutateGraphQL(query: travelerMutation, token: idpToken);
    }

    final traveler = Traveler.fromJson(travelerJson);
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