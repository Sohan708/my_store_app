import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store_app/controllers/category_controller.dart';
import 'package:my_store_app/controllers/subcategory_controller.dart';
import 'package:my_store_app/models/category.dart';
import 'package:my_store_app/models/subcategory.dart';
import 'package:my_store_app/view/screens/detail/screens/widgets/subcategory_title_widget.dart';
import 'package:my_store_app/view/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //future that woll hold the list of categories onece it is fetched from api
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  List<SubCategory> _subCategories = [];
  final SubCategoryController _subCategoryController = SubCategoryController();
  @override
  void initState() {
    //initialize the futureCategories with the list of categories
    super.initState();
    futureCategories = CategoryController().loadCategories();
    //once the categories are loaded, load the subcategories
    futureCategories.then((categories) {
      for (var category in categories) {
        if (category.name == "Fashion") {
          //if "fashion" category is found set it as selected category
          setState(() {
            _selectedCategory = category;
          });
          //load the subcategories for the selected category
          _loadSubCategories(category.name);
        }
      }
    });
  }

  //this will load the subcategories based on the selected category
  Future<void> _loadSubCategories(String categoryName) async {
    final subCategories = await _subCategoryController
        .getSubCategoriesByCategoryName(categoryName);
    setState(() {
      _subCategories = subCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side display categories
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubCategories(category.name);
                          },
                          selected: _selectedCategory == category,
                          selectedTileColor: Colors.blue.shade50,
                          tileColor: Colors.transparent,
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == category
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          //right side display products
          Expanded(
            flex: 5,
            child: _selectedCategory != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_selectedCategory!.banner),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        _subCategories.isNotEmpty
                            ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 4,
                                      childAspectRatio: 2 / 3,
                                    ),
                                itemCount: _subCategories.length,
                                itemBuilder: (context, index) {
                                  final subCategory = _subCategories[index];
                                  return SubCategoryTitleWidget(
                                    image: subCategory.image,
                                    title: subCategory.subCategoryName,
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "No Sub Categories",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
