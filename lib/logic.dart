import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortnerlink/model.dart';

class Logic extends GetxController {
  RxBool conexionStatus = false.obs;
  RxString linkAntigo = "".obs;
  TextEditingController urlController = TextEditingController();
  RxBool loading = false.obs;
  RxBool certo = false.obs;
  RxString link = 'Dê um link para converter'.obs;
  RxBool validURL = false.obs;
  restart() async {
    checkConection();
    urlController.text = '';
    urlController = TextEditingController();
    loading.value = false;
    certo.value = false;
    link.value = 'Dê um link para converter';
    validURL.value = false;
    linkAntigo.value = "";
  }

  Future<String> getLinkshortned(String longUrl) async {
    loading.value = true;
    Uri uri = Uri.parse("https://cleanuri.com/api/v1/shorten");
    final result = await http.post(uri, body: {"url": longUrl});

    if (result.statusCode == 200) {
      certo.value = true;
      loading.value = false;
      print("Bem Sucedido");
      print(result.body);
      var response = ResponseUrl.fromJson(jsonDecode(result.body));
      link.value = response.resultUrl;

      return response.resultUrl;
    } else {
      certo.value = false;
      loading.value = false;
      print("erro na API");
      print(result.body);
      link.value = "Url Inválido";
      loading.value = false;
      return 'Url Inválido';
    }
  }

  Future<bool> checkConection() async {
    var c;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          conexionStatus.value = true;
          // if (!Platform.isAndroid || !Platform.isIOS)
          c = true;
          return c;
        }
      } else {
        conexionStatus.value = true;
        return c;
      }
    } on SocketException catch (_) {
      c = false;
      conexionStatus.value = false;

      print("bom dia");
    }
    return c;
  }

  onLinkPrev() {
    Get.appUpdate();
  }
}
