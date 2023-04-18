import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/use_case/delete_cart_item_use_case.dart';

part 'delete_cart_item_event.dart';
part 'delete_cart_item_state.dart';

class DeleteCartItemBloc extends Bloc<DeleteCartItemEvent, DeleteCartItemState> {
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  Map<int, bool> isCartProductLoading = {};

  DeleteCartItemBloc(this._deleteCartItemUseCase) : super(DeleteCartItemInitial()) {
    on<DeleteCartItemEvent>((event, emit) async {
      if(event is PostDeleteCartItemEvent){
        isCartProductLoading[event.cartItemId] = false;
        await Future.wait([deleteCartItem(event, emit)]);
      }
    });
  }


  Future<void> deleteCartItem(event, emit) async {
    isCartProductLoading[event.cartItemId] = true;
    emit(DeleteCartItemLoadingState());

    (await _deleteCartItemUseCase.execute(
        DeleteCartItemUseCaseInput(
            event.cartItemId))).fold((failure) {

      isCartProductLoading[event.cartItemId] = false;
      emit(DeleteCartItemErrorState(failure.message));

    }, (data) {
      emit(DeleteCartItemSuccessState(data.message));
    });
  }
}
