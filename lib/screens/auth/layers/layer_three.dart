import 'package:app_aerofarallones/constants.dart';
import 'package:app_aerofarallones/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayerThree extends StatelessWidget {
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 584,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 35,
            left: 59,
            child: Container(
              child: Text(
                'Log In',
                style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor),
              ),
            ),
          ),
          Positioned(
            left: 59,
            top: 150,
            child: Text(
              'API KEY',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            left: 59,
            top: 180,
            child: Container(
              width: 310,
              child: TextField(
                controller: _apiKeyController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter API KEY',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            right: 60,
            top: 296,
            child: Text(
              'What is my API KEY?',
              style: TextStyle(
                  color: Constants.secondaryColor,
                  fontSize: 16,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            top: 365,
            right: 60,
            child: Container(
              width: 99,
              height: 35,
              decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: TextButton(
                  style: ButtonStyle(
                    padding:
                        WidgetStateProperty.all(EdgeInsets.zero), // Sin padding
                    backgroundColor: WidgetStateProperty.all(
                        Colors.transparent), // Fondo transparente
                  ),
                  onPressed: () async {
                    final apiKey = _apiKeyController.text.trim();
                    if (apiKey.isNotEmpty) {
                      try {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .login(apiKey);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('AeroFarallones - Error'),
                            content: const Text(
                                'API Key inválida. Inténtalo de nuevo.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
