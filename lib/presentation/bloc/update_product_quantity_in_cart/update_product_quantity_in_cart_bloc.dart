import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/domain/use_case/update_product_quantity_in_cart_use_case.dart';

part 'update_product_quantity_in_cart_event.dart';
part 'update_product_quantity_in_cart_state.dart';

class UpdateProductQuantityInCartBloc extends Bloc<
    UpdateProductQuantityInCartEvent, UpdateProductQuantityInCartState> {
  final UpdateProductQuantityInCartUseCase _updateProductQuantityInCartUseCase;
  Map<int, bool> isUpdateCartProductLoading = {};

  UpdateProductQuantityInCartBloc(this._updateProductQuantityInCartUseCase)
      : super(UpdateProductQuantityInCartInitial()) {
    on<UpdateProductQuantityInCartEvent>((event, emit) async {
      if (event is PostUpdateProductQuantityInCartEvent) {
        isUpdateCartProductLoading[event.cartItemId] = false;
        await Future.wait([_updateProductQuantityInCart(event, emit)]);
      }
    });
  }

  Future<void> _updateProductQuantityInCart(event, emit) async {
    isUpdateCartProductLoading[event.cartItemId] = true;
    emit(UpdateProductQuantityInCartLoadingState());

    (await _updateProductQuantityInCartUseCase.execute(
            UpdateProductQuantityInCartUseCaseInputs(
                event.cartItemId, event.quantity)))
        .fold(
      (failure) {
        isUpdateCartProductLoading[event.cartItemId] = false;
        emit(UpdateProductQuantityInCartErrorState(failure.message));
      },
      (data) {

        emit(UpdateProductQuantityInCartSuccessState());
      },
    );
  }
}
