import "package:graphql_flutter/graphql_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class APIClient {

  static const String idpTokenKey = "Bearer Token";
  GraphQLClient? _gqlClient;

  Future<dynamic> queryGraphQL({required String documentQuery, Map<String, dynamic> vars = const {}}) async {
    _gqlClient ??= await _getGraphQLClient();

    var result = await _gqlClient!.query(QueryOptions(
        document: gql(documentQuery),
        variables: vars,
        fetchPolicy: FetchPolicy.cacheAndNetwork
      )
    );

    return result.data?.values.toList()[1];
  }

  Future<dynamic> mutateGraphQL({required String documentQuery, Map<String, dynamic> vars = const {}}) async {
    _gqlClient ??= await _getGraphQLClient();

    var result = await _gqlClient!.mutate(MutationOptions(
        document: gql(documentQuery),
        variables: vars,
        fetchPolicy: FetchPolicy.cacheAndNetwork
      )
    );

    return result.data?.values.toList()[1];
  }

  Future<GraphQLClient> _getGraphQLClient() async {
    final idpToken = await const FlutterSecureStorage().read(key: idpTokenKey);
    final HttpLink httpLink = HttpLink("http://10.0.2.2:5230/graphql");
    final AuthLink authLink = AuthLink(getToken: () => "Bearer $idpToken");
    final Link link = authLink.concat(httpLink);
    
    return GraphQLClient(
      link: link,
      cache: GraphQLCache()
    );
  }
}

final apiClientProvider = Provider((ref) => APIClient());