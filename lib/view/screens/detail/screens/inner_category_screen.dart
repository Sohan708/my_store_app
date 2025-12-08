import 'package:flutter/material.dart';
import 'package:my_store_app/models/category.dart';
import 'package:my_store_app/view/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:my_store_app/view/screens/detail/screens/widgets/inner_header_widget.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  const InnerCategoryScreen({super.key, required this.category});
  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.12,
        ),
        child: const InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [InnerBannerWidget(image: widget.category.banner)],
        ),
      ),
    );
  }
}
