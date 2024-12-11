import 'package:app_aerofarallones/screens/auth/layers/layer_one.dart';
import 'package:app_aerofarallones/screens/auth/layers/layer_three.dart';
import 'package:app_aerofarallones/screens/auth/layers/layer_two.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/primaryBg.png'),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 100,
              left: 30,
              child: Image.asset(
                'assets/logo.png',
                width: 350,
              ),
            ),
            Positioned(top: 290, right: 0, bottom: 0, child: LayerOne()),
            Positioned(top: 318, right: 0, bottom: 28, child: LayerTwo()),
            Positioned(top: 320, right: 0, bottom: 48, child: LayerThree()),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Iniciar Sesión')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: _apiKeyController,
  //             decoration: const InputDecoration(labelText: 'API Key'),
  //           ),
  //           const SizedBox(height: 16),
  //           ElevatedButton(
  //             onPressed: () async {
  //               final apiKey = _apiKeyController.text.trim();
  //               if (apiKey.isNotEmpty) {
  //                 try {
  //                   await Provider.of<AuthProvider>(context, listen: false)
  //                       .login(apiKey);
  //                 } catch (e) {
  //                   showDialog(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                       title: const Text('AeroFarallones - Error'),
  //                       content:
  //                           const Text('API Key inválida. Inténtalo de nuevo.'),
  //                       actions: [
  //                         TextButton(
  //                           onPressed: () => Navigator.pop(context),
  //                           child: const Text('OK'),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }
  //               }
  //             },
  //             child: const Text('Iniciar Sesión'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
