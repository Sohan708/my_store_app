import 'package:http/http.dart' as http;
import 'package:my_store_app/global_variables.dart';
import 'package:my_store_app/models/subcategory.dart';
import 'dart:convert';

class SubCategoryController {
  Future<List<SubCategory>> getSubCategoriesByCategoryName(
    String categoryName,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data.map((json) => SubCategory.fromJson(json)).toList();
        } else {
          print("subcategory not found");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("subcategory not found");
        return [];
      } else {
        print('Failed to fetch subcategories');
        return [];
      }
    } catch (e) {
      print('Failed to fetch subcategories');
      return [];
    }
  }
}
