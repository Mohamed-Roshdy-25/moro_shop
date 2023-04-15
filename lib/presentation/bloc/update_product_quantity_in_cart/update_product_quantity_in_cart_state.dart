part of 'update_product_quantity_in_cart_bloc.dart';

abstract class UpdateProductQuantityInCartState extends Equatable {
  const UpdateProductQuantityInCartState();
}

class UpdateProductQuantityInCartInitial extends UpdateProductQuantityInCartState {
  @override
  List<Object> get props => [];
}

class UpdateProductQuantityInCartLoadingState extends UpdateProductQuantityInCartState {
  @override
  List<Object> get props => [];
}

class UpdateProductQuantityInCartSuccessState extends UpdateProductQuantityInCartState {
  @override
  List<Object> get props => [];
}

class UpdateProductQuantityInCartErrorState extends UpdateProductQuantityInCartState {
  final String message;

  const UpdateProductQuantityInCartErrorState(this.message);

  @override
  List<Object> get props => [message];
}