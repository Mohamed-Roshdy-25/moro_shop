// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/categories_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesUseCase categoryUseCase;
  List<CategoryModel>? categories;

  CategoryBloc(this.categoryUseCase) : super(CategoryInitial()) {
    on<CategoryEvent>(
      (event, emit) async {
        if (event is GetCategoriesEvent) {
          await _getCategories(emit,event);
        }
      },
      transformer: sequential(),
    );
  }


  Future<void> _getCategories(emit,event) async {
    emit(CategoriesLoadingState());

    (await categoryUseCase.execute(Void)).fold(
          (failure) {
        emit(CategoriesErrorState(failure.message));
      },
          (data) {
        categories = data.categoriesDataModel?.categoriesModel;
        emit(CategoriesSuccessState(data));
      },
    );
  }
}
