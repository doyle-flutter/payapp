import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payapp/Pages/ItemDetailPage.dart';

class ShoppingPage extends StatelessWidget {

  String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          documentNode: gql(this.readRepositories),
        ),
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
//          if (result.hasException) return Text(result.exception.toString());
//          if (result.loading) return Text('Loading');
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: () => this.itemSelect(context:context),
                child: Center(
                  child: Text("Item $index"),
                ),
              );
            }
          );
        },
      ),
    );
  }

  void itemSelect({@required BuildContext context}){
    assert(context != null);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemDetailPage()
      )
    );
  }
}
