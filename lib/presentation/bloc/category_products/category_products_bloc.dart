import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/add_delete_favorites_use_case.dart';
import 'package:moro_shop/domain/use_case/category_products_use_case.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  final CategoryProductsUseCase categoryProductsUseCase;
  final AddOrDeleteFavoritesUseCase _addOrDeleteFavoritesUseCase;
  List<ProductModel> categoryProductsList = [];
  Map<int, bool> inFavorites = {};
  Map<int, bool> isLoading = {};

  CategoryProductsBloc(
      this.categoryProductsUseCase, this._addOrDeleteFavoritesUseCase)
      : super(CategoryProductsInitial()) {
    on<CategoryProductsEvent>((event, emit) async {
      if (event is GetCategoryProductsEvent) {
       await _getCategoryProducts(emit,event);
      }

      if (event is PostAddOrDeleteFavoritesEvent) {
        isLoading[event.productId] = true;
        emit(AddOrDeleteFavoritesLoadingState());

        (await _addOrDeleteFavoritesUseCase.execute(
            AddOrDeleteFavoritesUseCaseInput(
                event.productId, event.categoryId)))
            .fold((failure) {
          isLoading[event.productId] = false;
          emit(AddOrDeleteFavoritesErrorState(failure.message));
        }, (data) {
          isLoading[event.productId] = false;
          emit(AddOrDeleteFavoritesLoadingState());
          inFavorites[event.productId] =
          !inFavorites[event.productId].orFalse();
          emit(AddOrDeleteFavoritesSuccessState(data.message));
        });
      }
    },
      transformer: sequential(),
    );
  }


  Future<void> _getCategoryProducts(emit,event) async{
    emit(GetCategoryProductsLoadingState());
    (await categoryProductsUseCase
        .execute(CategoryProductsUseCaseInput(event.categoryId)))
        .fold(
          (failure) {
        debugPrint('=============================================error');
        emit(GetCategoryProductsErrorState(failure.message));
      },
          (data) {
        for (ProductModel element
        in data.categoryAllProductsModel?.products ?? []) {
          inFavorites.addAll({element.id: element.inFavorites});
          isLoading.addAll({element.id: element.isLoading});
        }

        categoryProductsList =
            data.categoryAllProductsModel?.products ?? [];
        emit(GetCategoryProductsSuccessState(data));
      },
    );
  }
}
