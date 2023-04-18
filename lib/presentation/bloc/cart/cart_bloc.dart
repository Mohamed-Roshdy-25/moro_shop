// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/carts_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartsUseCase _cartsUseCase;
  List<CartProductModel>? cartItems;
  double? totalPrice;


  CartBloc(this._cartsUseCase) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCartEvent) {
        await Future.wait([_getCart(event, emit)]);
      }
    });
  }

  Future<void> _getCart(event, emit) async {
    emit(GetCartLoadingState());

    (await _cartsUseCase.execute(Void)).fold(
      (failure) {
        emit(GetCartErrorState(failure.message));
      },
      (data) {
        totalPrice = data.cartAllProductsDataModel?.totalPrice??0;
        cartItems = data.cartAllProductsDataModel?.cartProducts;
        emit(GetCartSuccessState(data));
      },
    );
  }
}
