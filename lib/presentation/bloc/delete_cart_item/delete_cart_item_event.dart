part of 'delete_cart_item_bloc.dart';

abstract class DeleteCartItemEvent extends Equatable {
  const DeleteCartItemEvent();
}

class PostDeleteCartItemEvent extends DeleteCartItemEvent {
  final int cartItemId;

  const PostDeleteCartItemEvent(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}