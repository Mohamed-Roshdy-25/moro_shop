import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/category_products_use_case.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  final CategoryProductsUseCase categoryProductsUseCase;
  List<ProductModel> categoryProductsList = [];

  CategoryProductsBloc(
      this.categoryProductsUseCase)
      : super(CategoryProductsInitial()) {
    on<CategoryProductsEvent>(
      (event, emit) async {
        if (event is GetCategoryProductsEvent) {

          await Future.wait([_getCategoryProducts(emit, event)]);
        }

      },
    );
  }

  Future<void> _getCategoryProducts(emit, event) async {
    emit(GetCategoryProductsLoadingState());
    (await categoryProductsUseCase
            .execute(CategoryProductsUseCaseInput(event.categoryId)))
        .fold(
      (failure) {
        emit(GetCategoryProductsErrorState(failure.message));
      },
      (data) {
        categoryProductsList = data.categoryAllProductsModel?.products ?? [];
        emit(GetCategoryProductsSuccessState(data));
      },
    );
  }


}
