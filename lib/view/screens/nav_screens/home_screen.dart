import 'package:flutter/material.dart';
import 'package:my_store_app/view/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:my_store_app/view/screens/nav_screens/widgets/resuable_text_widget.dart';
import 'widgets/banner_widget.dart';
import 'widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItemWidget(),
            ResuableTextWidget(
              title: "Popular Products",
              subtitle: "Popular Products",
            ),
          ],
        ),
      ),
    );
  }
}
