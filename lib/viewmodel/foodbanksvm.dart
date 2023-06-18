// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_provider/api/foodbankApi.dart';
import 'package:test_provider/model/foodbank.dart';

class FoodBankModel extends ChangeNotifier {
  List<FoodBank> foodbanks = [];
  List<FoodBank> foodbanksByLocation = [];
  List<FoodBank> foodbanksByNeeds = [];
  Set<String> needs = {};
  String dropdownValue = "";
  int status = 1;

  Future<void> getFoodBanksFromApi() async {
    try {
      var response = await getfoodbanks();
      List<dynamic> foodbanksRaw = List.from(jsonDecode(response!.body));
      foodbanksRaw.forEach((element) {
        foodbanks.add(FoodBank.fromJson(element));
      });

      foodbanks.first.name != null
          ? print("getFoodBanksFromApi Complete")
          : print("getFoodBanksFromApi Fail");
      status = 1;
    } catch (e) {
      print("getFoodBanksFromApi $e");
      status = -1;
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  Future<void> getFoodBanksSearchFromApi(String address) async {
    foodbanksByLocation.clear();
    needs.clear();
    if (address.isNotEmpty) {
      try {
        var response = await getfoodbankSearchByLocation(address);
        // Update foodbanksByLocation
        List<dynamic> foodbanksRaw = List.from(jsonDecode(response!.body));
        foodbanksRaw.forEach((element) {
          foodbanksByLocation.add(FoodBank.fromJson(element));
        });
        // Update needs
        foodbanksByLocation.forEach((element) {
          List<String> subneeds = element.needs!["needs"]!.split("\n");
          subneeds.forEach((element) {
            needs.add(element);
          });
        });
        dropdownValue = needs.first;
        // Update foodbanksByNeeds
        foodbanksByLocation.forEach((element) {
          String subneeds = element.needs!["needs"];
          if (subneeds.contains(dropdownValue)) {
            foodbanksByNeeds.add(element);
          }
        });

        foodbanks.first.name != null
            ? print("getFoodBanksSearchFromApi Found")
            : print("getFoodBanksSearchFromApi No Result");

        status = 1;
      } catch (e) {
        print("getFoodBanksSearchFromApi $e");
        status = -1;
        notifyListeners();
        return;
      }
    }
    notifyListeners();
  }

  void updatefoodbanksByNeeds() {
    foodbanksByNeeds.clear();
    foodbanksByLocation.forEach((element) {
      String subneeds = element.needs!["needs"];
      if (subneeds.contains(dropdownValue)) {
        foodbanksByNeeds.add(element);
      }
    });
  }
}
