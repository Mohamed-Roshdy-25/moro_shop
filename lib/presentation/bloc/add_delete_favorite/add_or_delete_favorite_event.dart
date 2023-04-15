part of 'add_or_delete_favorite_bloc.dart';

abstract class AddOrDeleteFavoriteEvent extends Equatable {
  const AddOrDeleteFavoriteEvent();
}

class PostAddOrDeleteFavoritesEvent extends AddOrDeleteFavoriteEvent {
  final int productId;
  final String categoryId;


  const PostAddOrDeleteFavoritesEvent(this.productId, this.categoryId);

  @override
  List<Object?> get props => [productId,categoryId];
}
