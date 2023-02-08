import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_project/lend_borrow_screen.dart';
import 'dynamic_link_handler.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
    DynamicLinkHandler().initUniLinks();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        'https://gateway.thegraph.com/api/[api-key]/subgraphs/id/HB1Z2EAw4rtPRYVb2Nz8QGFLHCpym6ByBX6vbCViuE9F');
    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache()),
    );
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {},
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
        ),
        home: LendBorrowScreen(),
      ),
    );
  }
}
