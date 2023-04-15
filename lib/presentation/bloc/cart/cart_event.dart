part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCartEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}