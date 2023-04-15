part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteState extends Equatable {
  const DeleteFavoriteState();
}

class DeleteFavoriteInitial extends DeleteFavoriteState {
  @override
  List<Object> get props => [];
}

class DeleteFavoriteLoadingState extends DeleteFavoriteState {
  @override
  List<Object?> get props => [];
}

class DeleteFavoriteSuccessState extends DeleteFavoriteState {
  final String message;

  const DeleteFavoriteSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteFavoriteErrorState extends DeleteFavoriteState {
  final String message;

  const DeleteFavoriteErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
