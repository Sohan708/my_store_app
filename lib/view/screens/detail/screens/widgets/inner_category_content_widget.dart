import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store_app/controllers/subcategory_controller.dart';
import 'package:my_store_app/models/category.dart';
import 'package:my_store_app/models/subcategory.dart';
import 'package:my_store_app/view/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:my_store_app/view/screens/detail/screens/widgets/subcategory_title_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({super.key, required this.category});
  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<SubCategory>> _subCategories;
  final SubCategoryController _subCategoryController = SubCategoryController();
  @override
  void initState() {
    super.initState();
    _subCategories = _subCategoryController.getSubCategoriesByCategoryName(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Shop By Category",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Subcategories available'),
                  );
                } else {
                  final subCategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate((subCategories.length / 7).ceil(), (
                        setIndex,
                      ) {
                        //for each row , calculate the startting and ending indices
                        final start = setIndex * 7;
                        final end = (setIndex + 1) * 7;
                        //create a padding widget to add spacing arround the row
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //create a row of the subcategories titles
                            children: subCategories
                                .sublist(
                                  start,
                                  end > subCategories.length
                                      ? subCategories.length
                                      : end,
                                )
                                .map(
                                  (subCategory) => SubCategoryTitleWidget(
                                    image: subCategory.image,
                                    title: subCategory.subCategoryName,
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
