import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eRestaurant/src/helpers/screen_navigation.dart';
import 'package:eRestaurant/src/helpers/style.dart';
import 'package:eRestaurant/src/providers/app.dart';
import 'package:eRestaurant/src/providers/category.dart';
import 'package:eRestaurant/src/providers/product.dart';
import 'package:eRestaurant/src/providers/promotion.dart';
import 'package:eRestaurant/src/providers/user.dart';
import 'package:eRestaurant/src/screens/booking.dart';
import 'package:eRestaurant/src/screens/cart.dart';
import 'package:eRestaurant/src/screens/category.dart';
import 'package:eRestaurant/src/screens/login.dart';
import 'package:eRestaurant/src/screens/order.dart';
import 'package:eRestaurant/src/screens/product_search.dart';
import 'package:eRestaurant/src/screens/promotion.dart';
import 'package:eRestaurant/src/screens/reward.dart';
import 'package:eRestaurant/src/widgets/categories.dart';
import 'package:eRestaurant/src/widgets/custom_text.dart';
import 'package:eRestaurant/src/widgets/featured_products.dart';
import 'package:eRestaurant/src/widgets/loading.dart';
import 'package:eRestaurant/src/widgets/promotion.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final promotionProvider = Provider.of<PromotionProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    promotionProvider.loadSinglePromotion();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "eRestaurant",
          color: yellow,
          weight: FontWeight.bold,
          size: 24,
        ),
        // actions: <Widget>[
        //   Stack(
        //     children: <Widget>[
        //       IconButton(
        //         icon: Icon(Icons.account_circle_rounded),
        //         onPressed: () {
        //           changeScreen(context, ProfileScreen());
        //         },
        //       ),
        //     ],
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name ?? "Hello, ",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email address",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreenReplacement(context, BookingScreen());
              },
              leading: Icon(Icons.calendar_today),
              title: CustomText(text: "Book a table"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My bookings"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, RewardScreen());
              },
              leading: Icon(Icons.star),
              title: CustomText(text: "Rewards"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: bg,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              await productProvider.search(
                                  productName: pattern);
                              changeScreen(context, ProductSearchScreen());
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                              hintText: "Find food",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              app.changeLoading();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);

                              changeScreen(
                                  context,
                                  CategoryScreen(
                                    categoryModel:
                                        categoryProvider.categories[index],
                                  ));

                              app.changeLoading();
                            },
                            child: CategoryWidget(
                              category: categoryProvider.categories[index],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Featured menu",
                          size: 20,
                          color: black,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Deals and Promotions",
                          size: 20,
                          color: black,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: promotionProvider.promotions
                        .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();

                                await productProvider.loadProductsByPromotion(
                                    promotionId: item.id);
                                app.changeLoading();

                                changeScreen(
                                    context,
                                    PromotionScreen(
                                      promotionModel: item,
                                    ));
                              },
                              child: PromotionWidget(
                                promotion: item,
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
