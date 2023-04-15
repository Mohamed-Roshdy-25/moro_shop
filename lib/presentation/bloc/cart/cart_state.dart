part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class GetCartLoadingState extends CartState{
  @override
  List<Object?> get props => [];
}

class GetCartSuccessState extends CartState{
  final CartsAllDataModel cartsAllDataModel;

  const GetCartSuccessState(this.cartsAllDataModel);

  @override
  List<Object?> get props => [cartsAllDataModel];
}

class GetCartErrorState extends CartState{
  final String message;

  const GetCartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
