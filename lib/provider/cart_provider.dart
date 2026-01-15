import 'package:flutter_riverpod/legacy.dart';

import '../models/cart.dart';

//Define a StateNotifierProvider to expose an instance of CartNotifier
//Makeing it assessible to the entire app
final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((
  ref,
) {
  return CartNotifier();
});
//A notifier class to manage the cart state, extending stateNotifier
//with an initial state of empty map

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  //Method to add a product to the cart
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    //check if the product is alredy in the cart
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: Cart(
          productName: state[productId]!.productId,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          productId: state[productId]!.productId,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName,
        ),
      };
    } else {
      //if the product is not in the cart, add it with the provied details
      state = {
        ...state,
        productId: Cart(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          productId: productId,
          description: description,
          fullName: fullName,
        ),
      };
    }
  }

  //Method to increment the quantity opf a product in the cart
  // ignore: non_constant_identifier_names
  void IncrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
      //notify lisitener that the state has changed
      state = {...state};
    }
  }

  //Method to decrement the quantity of a product in the cart
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      //Notify listerners that the state has changed
      state = {...state};
    }
  }

  //Method to remove item form the cart
  void removeCartItem(String productId) {
    state.remove(productId);
    //Notify Listerners that the sate has changed
  }

  //Method to calculate total amount of items we have in cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });

    return totalAmount;
  }
}
