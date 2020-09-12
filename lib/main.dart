import 'package:find_my_tecky_choferes_v2/pages/accseso.dart';
import 'package:find_my_tecky_choferes_v2/pages/home.dart';
import 'package:find_my_tecky_choferes_v2/pages/loading.dart';
import 'package:find_my_tecky_choferes_v2/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: {
          'home': ( _ ) => HomePage(),
          'acceso': ( _ ) => AccesoPage(),
          'loading': ( _ ) => LoadingPage()
        },
      ),
    );
  }
}