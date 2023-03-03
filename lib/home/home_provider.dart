import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_starter/home/models/placeholder_data.dart';

class HomeProvider extends ChangeNotifier {
  bool loader = false;
  int value = 0;
  List<PlaceholderData> parsedData = [];

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    if (value > 0) {
      value--;
    }
    notifyListeners();
  }

  apiCall() async {
    try {
      loader = true;
      notifyListeners();
      http.Response response =
          await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      List<dynamic> list = json.decode(response.body);
      if (list.isNotEmpty) {
        parsedData
            .addAll(List.generate(list.length, (index) => PlaceholderData.fromJson(list[index])));
      }
      parsedData.forEach((element) {
        print("parseddata---------> ${element.toJson()}");
      });

      loader = false;
      notifyListeners();
    } catch (e) {
      print("error------- $e");
    }
  }
}
