import "package:graphql_flutter/graphql_flutter.dart";

//TODO: No need to pass "Query {} or Mutation {}"
class APIClient {

  Future<dynamic> queryGraphQL({required String query, required String token}) async {
    var client = _getGraphQLClient(token);

    var result = await client.query(QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.cacheAndNetwork
      )
    );

    return result.data?.values.toList()[1];
  }

  Future<dynamic> mutateGraphQL({required String query, required String token}) async {
    var client = _getGraphQLClient(token);

    var result = await client.mutate(MutationOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.cacheAndNetwork
      )
    );

    return result.data?.values.toList()[1];
  }

  GraphQLClient _getGraphQLClient(String idpToken) {
    final HttpLink httpLink = HttpLink("http://10.0.2.2:5230/graphql");
    final AuthLink authLink = AuthLink(getToken: () => "Bearer $idpToken");
    final Link link = authLink.concat(httpLink);
    
    return GraphQLClient(
      link: link,
      cache: GraphQLCache()
    );
  }
}