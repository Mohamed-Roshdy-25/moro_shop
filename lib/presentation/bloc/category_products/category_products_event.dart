part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();
}

class GetCategoryProductsEvent extends CategoryProductsEvent{
  final int categoryId;

  const GetCategoryProductsEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
