import "package:wander_pal/models/traveler.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:wander_pal/services/api_client.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:wander_pal/graphQL/queries/user_queries.dart";
import "package:wander_pal/graphQL/mutations/user_mutations.dart";
import "package:flutter_facebook_auth/flutter_facebook_auth.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AccountService {

  late final APIClient apiClient;

  AccountService({required this.apiClient});

  Future<void> setupAccount(UserCredential credential) async {
    final authUser = credential.user; //TODO: Throw exception if User is null
    final idpToken = await authUser!.getIdToken();
    const FlutterSecureStorage().write(key: APIClient.idpTokenKey, value: idpToken);

    final userQuery = UserQueries.getAccount();
    final travelerJson = await apiClient.queryGraphQL(documentQuery: userQuery);

    if (travelerJson == null) { // Create user
      var traveler = Traveler(1, "firstName", "lastName", DateTime.now(), "about", []);
      String travelerMutation = UserMutations.signUpTraveler(traveler);
      final t = apiClient.mutateGraphQL(documentQuery: travelerMutation);
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

final accountServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AccountService(apiClient: apiClient);
});
// https://firebase.google.com/docs/auth/flutter/federated-auth