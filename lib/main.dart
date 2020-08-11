import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cache_fetcher.dart';

import './screens/location_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CacheFetcher()),
      ],
      child: MaterialApp(
        title: 'KwiBerry',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitPage(),
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          LocationScreen.routeName: (_) => LocationScreen(),
        },
      ),
    );
  }
}

//this is where we retrieve user datas using sharedpreferences from caches to prevent
//re-entering details and user locations
class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  bool locationExist = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<CacheFetcher>(context, listen: false)
            .retrieveLocation(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return LocationScreen();
          }
        });
    // Scaffold(
    //   body: SafeArea(
    //       child: Stack(
    //     children: [
    //       Container(
    //           decoration: BoxDecoration(
    //         image: DecorationImage(
    //             image: AssetImage('assets/images/veg.png'), fit: BoxFit.cover),
    //       )),
    //       BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    //         child: Container(color: Colors.black.withOpacity(0)),
    //       ),
    //     ],
    //   )),
    // );
  }
}
