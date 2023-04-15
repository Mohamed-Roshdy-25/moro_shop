part of 'add_or_delete_cart_bloc.dart';

abstract class AddOrDeleteCartState extends Equatable {
  const AddOrDeleteCartState();
}

class AddOrDeleteCartInitial extends AddOrDeleteCartState {
  @override
  List<Object> get props => [];
}

class AddOrDeleteCartsLoadingState extends AddOrDeleteCartState {
  @override
  List<Object?> get props => [];
}

class AddOrDeleteCartsSuccessState extends AddOrDeleteCartState {
  final String message;

  const AddOrDeleteCartsSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AddOrDeleteCartsErrorState extends AddOrDeleteCartState {
  final String message;

  const AddOrDeleteCartsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
