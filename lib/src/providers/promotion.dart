import 'package:flutter/material.dart';
import '../helpers/promotion.dart';
import '../models/promotion.dart';

class PromotionProvider with ChangeNotifier {
  PromotionServices _promotionServices = PromotionServices();
  List<PromotionModel> promotions = [];
  List<PromotionModel> searchedPromotions = [];

  PromotionModel promotion;

  PromotionProvider.initialize() {
    loadPromotions();
  }

  loadPromotions() async {
    promotions = await _promotionServices.getPromotions();
    notifyListeners();
  }

  loadSinglePromotion({String promotionId}) async {
    promotion = await _promotionServices.getPromotionById(id: promotionId);
    notifyListeners();
  }

  // Future search({String name}) async {
  //   searchedRestaurants =
  //       await _restaurantServices.searchRestaurant(restaurantName: name);
  //   print("RESTOS ARE: ${searchedRestaurants.length}");
  //   notifyListeners();
  // }
}
