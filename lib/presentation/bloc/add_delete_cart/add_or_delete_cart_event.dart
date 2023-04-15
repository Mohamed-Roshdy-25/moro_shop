part of 'add_or_delete_cart_bloc.dart';

abstract class AddOrDeleteCartEvent extends Equatable {
  const AddOrDeleteCartEvent();
}

class PostAddOrDeleteCartsEvent extends AddOrDeleteCartEvent {
  final int productId;
  final String categoryId;


  const PostAddOrDeleteCartsEvent(this.productId, this.categoryId);

  @override
  List<Object?> get props => [productId,categoryId];
}