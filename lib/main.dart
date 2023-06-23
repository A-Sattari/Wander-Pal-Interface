import "firebase_options.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wander_pal/presentation/authentication/login_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GraphQLClient graphQLClient = GraphQLClient(
    link: HttpLink("https://music-mates-fun.herokuapp.com/graphql"),
    cache: GraphQLCache(),
  );

  late final client = ValueNotifier<GraphQLClient>(graphQLClient);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
            title: "Wander Pal",
            theme: ThemeData(useMaterial3: true),
            home: Container(
              // margin: EdgeInsets.only(top: 50),
              // child: Scaffold(body: const GatheringPage())));
              child: LoginPage(),
            )));
  }
}