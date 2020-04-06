import 'package:payapp/Controllers/UserSettingDB.dart';
import 'package:payapp/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:payapp/Pages/MainPage.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserSettingDB>(
          lazy: false,
          create: (_) => new UserSettingDB(),
        ),
      ],
      child: MaterialApp(
        home: LoginCheck(),
      )
    ),
  );
}


class LoginCheck extends StatelessWidget {

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(
        uri: 'https://api.github.com/graphql',
      ),
    ),
  );

  final String addStar = """
  mutation AddStar(\$starrableId: ID!) {
    addStar(input: {starrableId: \$starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: Mutation(
          options: MutationOptions(
            onCompleted: (dynamic resultData){
              // print("resultData $resultData");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainPage(client: client,)
                )
              );
            },
            update: (Cache cache, QueryResult result) {
              return cache;
            },
            documentNode: gql(addStar)
          ),
          builder: (RunMutation runMutation, QueryResult result){
            return LoginPage(runMutation:runMutation);
          },
        )
      ),
    );
  }
}
