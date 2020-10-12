import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/promotion.dart';

class PromotionServices {
  String collection = "promotions";
  Firestore _firestore = Firestore.instance;

  Future<List<PromotionModel>> getPromotions() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<PromotionModel> promotions = [];
        for (DocumentSnapshot promotion in result.documents) {
          promotions.add(PromotionModel.fromSnapshot(promotion));
        }
        return promotions;
      });

  Future<PromotionModel> getPromotionById({String id}) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
        return PromotionModel.fromSnapshot(doc);
      });

  // Future<List<PromotionModel>> searchRestaurant({String restaurantName}) {
  //   // code to convert the first character to uppercase
  //   String searchKey =
  //       restaurantName[0].toUpperCase() + restaurantName.substring(1);
  //   return _firestore
  //       .collection(collection)
  //       .orderBy("name")
  //       .startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff'])
  //       .getDocuments()
  //       .then((result) {
  //         List<PromotionModel> restaurants = [];
  //         for (DocumentSnapshot product in result.documents) {
  //           restaurants.add(PromotionModel.fromSnapshot(product));
  //         }
  //         return restaurants;
  //       });
  // }
}
