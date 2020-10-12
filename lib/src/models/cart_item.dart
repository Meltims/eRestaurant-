import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const PROMOTION_ID = "promotionId";
  static const TOTAL_PROMOTION_SALES = "totalPromotionSale";

  String _id;
  String _name;
  String _image;
  String _productId;
  String _promotionId;
  int _totalPromotionSale;
  int _quantity;
  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get promotionId => _promotionId;

  int get price => _price;

  int get totalPromotionSale => _totalPromotionSale;

  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _totalPromotionSale = data[TOTAL_PROMOTION_SALES];
    _promotionId = data[PROMOTION_ID];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        QUANTITY: _quantity,
        PRICE: _price,
        PROMOTION_ID: _promotionId,
        TOTAL_PROMOTION_SALES: _totalPromotionSale
      };
}
