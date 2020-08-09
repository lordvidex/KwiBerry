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
      providers: [ChangeNotifierProvider.value(value: CacheFetcher())],
      child: MaterialApp(
        title: 'KwiBerry',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitPage(),
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
  void fetch() async {
    locationExist = await Provider.of<CacheFetcher>(context, listen: false)
        .retrieveLocation();
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return locationExist ? HomeScreen() : LocationScreen();
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
