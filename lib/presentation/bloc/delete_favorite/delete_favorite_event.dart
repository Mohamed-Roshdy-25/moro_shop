part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteEvent extends Equatable {
  const DeleteFavoriteEvent();
}

class PostDeleteFavoriteEvent extends DeleteFavoriteEvent {
  final int favoriteItemId;

  const PostDeleteFavoriteEvent(this.favoriteItemId);

  @override
  List<Object?> get props => [favoriteItemId];
}
