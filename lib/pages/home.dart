import 'dart:async';

import 'package:find_my_tecky_choferes_v2/colors/colors.dart';
import 'package:find_my_tecky_choferes_v2/pages/loading.server.dart';
import 'package:find_my_tecky_choferes_v2/services/socket.dart';
import 'package:find_my_tecky_choferes_v2/widgets/button.activate.dart';
import 'package:find_my_tecky_choferes_v2/widgets/header.detail.dart';
import 'package:find_my_tecky_choferes_v2/widgets/header.painter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String dropDownValue = 'centro';
  Location location = new Location();
  StreamSubscription<LocationData> locationSubscription;
  AnimationController animationController;
  Animation<double> move;
  bool activo = true;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (animationController.status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    move = Tween(begin: 0.0, end: 1.0).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: socketService.serverStatus != ServerStatus.Online
          ? LoadingServer()
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: CustomPaint(painter: HeaderPainter()),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: CustomPaint(painter: HeadersDetails()),
                          ),
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (context, Widget child) {
                              return Positioned(
                                top: MediaQuery.of(context).size.height * 0.211,
                                left: MediaQuery.of(context).size.width * 0.1,
                                child: Transform.translate(
                                  offset: Offset(move.value * 50, 0),
                                  child: Image.asset('assets/img/troka.png'),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 40,
                            left: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              'FMT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 120,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            'Selecciona una ruta y activa para transmitir la ubicación',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColoresApp.primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDropDownButton(),
                          const SizedBox(height: 20),
                          activo
                              ? ButtonActivate(
                                  color: ColoresApp.primaryLigth,
                                  icon: Icons.play_arrow,
                                  text: 'ACTIVAR',
                                  onPress: () {
                                    _getPositionStream();
                                  },
                                )
                              : ButtonActivate(
                                  color: ColoresApp.primary,
                                  icon: Icons.pause,
                                  text: 'PAUSAR',
                                  onPress: () {
                                    _pause();
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDropDownButton() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: ColoresApp.primaryLigth,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownButton(
            isExpanded: true,
            dropdownColor: ColoresApp.primaryLigth,
            underline: Divider(),
            elevation: 4,
            value: this.dropDownValue,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 30,
            ),
            items: <String>['centro', 'linares', 'rotaria']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                this.dropDownValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  _getPositionStream() {
    animationController.forward();
    final socketService = Provider.of<SocketService>(context, listen: false);
    activo = !activo;
    locationSubscription = location.onLocationChanged.listen((_locationData) {
      socketService.socket.emit('emit-ruta-$dropDownValue', {
        'lat': "${_locationData.latitude}",
        'lgn': "${_locationData.longitude}"
      });
    });
    setState(() {});
  }

  _pause() {
    locationSubscription.pause();
    animationController.stop();
    activo = !activo;
    setState(() {});
  }
}
