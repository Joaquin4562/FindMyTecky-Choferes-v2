import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoPage extends StatefulWidget {
  const AccesoPage({Key key}) : super(key: key);

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if ( state == AppLifecycleState.resumed ){
      if ( await Permission.location.isGranted ){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Es necesario activar el GPS para continuar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: const Color(0xffA85C5C),
              ),
            ),
            MaterialButton(
              color: const Color(0xffA85C5C),
              child: Text(
                'Activar GPS',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                final status = await Permission.location.request();
                this.accesoGPS( status, context );
              },
            )
          ],
        ),
      ),
    );
  }

  void accesoGPS(PermissionStatus status, BuildContext context) {
    switch ( status ){
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'home');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
