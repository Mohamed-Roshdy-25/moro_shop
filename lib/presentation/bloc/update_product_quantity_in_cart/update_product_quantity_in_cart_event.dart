part of 'update_product_quantity_in_cart_bloc.dart';

abstract class UpdateProductQuantityInCartEvent extends Equatable {
  const UpdateProductQuantityInCartEvent();
}

class PostUpdateProductQuantityInCartEvent extends UpdateProductQuantityInCartEvent{
  final int cartItemId;
  final int quantity;

  const PostUpdateProductQuantityInCartEvent(this.cartItemId, this.quantity);

  @override
  List<Object?> get props => [cartItemId,quantity];
}