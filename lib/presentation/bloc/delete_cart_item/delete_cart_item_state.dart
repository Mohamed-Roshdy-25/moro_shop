part of 'delete_cart_item_bloc.dart';

abstract class DeleteCartItemState extends Equatable {
  const DeleteCartItemState();
}

class DeleteCartItemInitial extends DeleteCartItemState {
  @override
  List<Object> get props => [];
}

class DeleteCartItemLoadingState extends DeleteCartItemState {
  @override
  List<Object?> get props => [];
}

class DeleteCartItemSuccessState extends DeleteCartItemState {
  final String message;

  const DeleteCartItemSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCartItemErrorState extends DeleteCartItemState {
  final String message;

  const DeleteCartItemErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

