part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();
}

class GetCategoryProductsEvent extends CategoryProductsEvent {
  final int categoryId;

  const GetCategoryProductsEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class PostAddOrDeleteFavoritesEvent extends CategoryProductsEvent {
  final int productId;
  final String categoryId;


  const PostAddOrDeleteFavoritesEvent(this.productId, this.categoryId);

  @override
  List<Object?> get props => [productId];
}
