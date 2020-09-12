import 'package:find_my_tecky_choferes_v2/widgets/loading.inicator.dart';
import 'package:flutter/material.dart';

class LoadingServer extends StatelessWidget {
  const LoadingServer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Contectandose al servidor...',
            style: TextStyle(
                color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoadingIndicator(),
        ],
      ),
    );
  }
}
