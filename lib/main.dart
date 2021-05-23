import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import 'package:string_validator/string_validator.dart';
import 'AboutPage.dart';
import 'logic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Logic logic = Get.put(Logic());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  logic.checkConection();
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topCenter,
                          height: Get.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => logic.conexionStatus.value
                                  ? SizedBox.shrink()
                                  : Text(
                                      'Verifique a Sua conexão',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () => logic.restart()),
                                  IconButton(
                                      icon: Icon(Icons.help),
                                      onPressed: () =>
                                          Get.to(() => AboutPage())),
                                ],
                              )
                            ],
                          )),
                      Container(
                          height: Get.height * 0.2,
                          width: Get.width * 0.4,
                          child: Image.asset(
                            "lib/logo2.png",
                            color: Colors.orange,
                          )),
                      Text("Encurtador de Links",
                          style: TextStyle(color: Colors.orange, fontSize: 24)),
                      Text("Deixe o seu Link Atrativo rapidamente",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        logic.validURL.value = isURL(value);
                                        if (logic.validURL.value) {
                                          logic.linkAntigo.value = value;
                                        }
                                      });
                                    },
                                    controller: logic.urlController,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(Icons.paste),
                                            onPressed: () {
                                              FlutterClipboard.paste()
                                                  .then((value) {
                                                setState(() {
                                                  logic.urlController.text =
                                                      value;
                                                });
                                              });
                                            }),
                                        border: InputBorder.none,
                                        hintText: 'Cole o Link')),
                              ))),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Link: "),
                                ]),
                            Row(
                              children: [
                                Obx(() => SelectableText(logic.link.value)),
                                IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: () {
                                    FlutterClipboard.copy(logic.link.value);
                                    Get.rawSnackbar(
                                        message: "Copiado",
                                        duration: Duration(seconds: 2));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          child: Obx(() => logic.certo.value
                              ? AnyLinkPreview(
                                  link: logic.linkAntigo.value,
                                  displayDirection:
                                      UIDirection.UIDirectionHorizontal,
                                  showMultimedia: true,
                                  bodyMaxLines: 5,
                                  bodyTextOverflow: TextOverflow.ellipsis,
                                  titleStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )
                              : SizedBox(height: Get.height * 0.15)),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.16),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                              width: Get.width * 0.9,
                              color: Colors.orange,
                              height: Get.height * 0.09,
                              child: TextButton(
                                  onPressed: () async {
                                    Get.appUpdate();
                                    if (logic.conexionStatus.value) {
                                      logic.validURL.value =
                                          isURL(logic.urlController.text);

                                      if (logic.urlController.text.isBlank) {
                                        logic.loading.value = false;
                                        Get.rawSnackbar(
                                            message:
                                                ' Cole o Link que deseja converter');
                                      } else {
                                        var link = await logic.getLinkshortned(
                                            logic.urlController.text);
                                        print(link);
                                        logic.urlController =
                                            TextEditingController();
                                      }
                                    } else {
                                      Get.rawSnackbar(
                                          message: 'Verifique a Sua Conexão',
                                          mainButton: TextButton(
                                              onPressed: () async =>
                                                  Get.appUpdate(),
                                              child: Icon(Icons.refresh)));
                                    }
                                  },
                                  child: Obx(() => logic.loading.value
                                      ? CircularProgressIndicator.adaptive(
                                          backgroundColor: Colors.white,
                                          strokeWidth: 1,
                                        )
                                      : Text("Encurtar",
                                          style: TextStyle(
                                              color: Colors.white)))))),
                    ],
                  ),
                ),
              ),
            )));
  }
}
