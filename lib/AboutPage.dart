import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: Get.height * 0.2,
                          width: Get.width * 0.4,
                          child: Image.asset(
                            "lib/logo2.png",
                            color: Colors.orange,
                          )),
                    ],
                  ),
                  Text("Encurtador de Links",
                      style: TextStyle(color: Colors.orange, fontSize: 24)),
                  Text("Deixe o seu Link Atrativo rapidamente",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Programador: ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                          Text("Ildeberto Silva",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.16,
                      ),
                    ],
                  ),
                ],
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.report),
                  label: Text("Reportar Erro",
                      style: TextStyle(color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }
}
