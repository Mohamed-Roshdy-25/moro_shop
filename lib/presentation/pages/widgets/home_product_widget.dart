import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/add_delete_cart/add_or_delete_cart_bloc.dart';
import 'package:moro_shop/presentation/bloc/add_delete_favorite/add_or_delete_favorite_bloc.dart';
import 'package:moro_shop/presentation/bloc/category_products/category_products_bloc.dart';
import 'package:moro_shop/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/favorite_button.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class HomeProductsWidget extends StatefulWidget {
  final int categoryId;

  const HomeProductsWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<HomeProductsWidget> createState() => _HomeProductsWidgetState();
}

class _HomeProductsWidgetState extends State<HomeProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<CategoryProductsBloc>()..add(GetCategoryProductsEvent(widget.categoryId)),),
        BlocProvider(create: (context) => instance<AddOrDeleteFavoriteBloc>(),),
        BlocProvider(create: (context) => instance<AddOrDeleteCartBloc>(),),
        BlocProvider(create: (context) => instance<FavoritesBloc>(),),
      ],
      child: BlocConsumer<CategoryProductsBloc, CategoryProductsState>(
        listener: (context, state) {
          if (state is GetCategoryProductsSuccessState) {
            for (ProductModel element in state
                    .categoryAllDataModel.categoryAllProductsModel?.products ??
                []) {
              BlocProvider.of<AddOrDeleteFavoriteBloc>(context)
                  .inFavorites
                  .addAll({element.id: element.inFavorites});
              BlocProvider.of<AddOrDeleteFavoriteBloc>(context)
                  .isFavoriteProductLoading
                  .addAll({element.id: element.isLoading});

              BlocProvider.of<AddOrDeleteCartBloc>(context)
                  .inCarts
                  .addAll({element.id: element.inCart});
              BlocProvider.of<AddOrDeleteCartBloc>(context)
                  .isCartProductLoading
                  .addAll({element.id: element.isLoading});
            }
          }
        },
        builder: (context, state) {
          List<ProductModel>? products =
              BlocProvider.of<CategoryProductsBloc>(context)
                  .categoryProductsList;

          if (products.isNotEmpty) {
            return BlocConsumer<AddOrDeleteFavoriteBloc,
                AddOrDeleteFavoriteState>(listener: (context, state) {
              _onAddOrDeleteFavoriteErrorState(state, context);
              _onAddOrDeleteFavoriteSuccessState(state, context);
            }, builder: (context, state) {
              return _productsGridView(products);
            });
          }
          if (state is GetCategoryProductsErrorState) {
            return ErrorState(
                    StateRendererType.fullScreenErrorState, state.message)
                .getScreenWidget(context, retryActionFunction: () {
              BlocProvider.of<CategoryProductsBloc>(context)
                  .add(GetCategoryProductsEvent(widget.categoryId));
            }, buttonTitle: AppStrings.retryAgain);
          }else if(state is CategoryProductsInitial){
            return Container();
          }
          else {
            return LoadingState(
                    stateRendererType: StateRendererType.fullScreenLoadingState)
                .getScreenWidget(context);
          }
        },
      ),
    );
  }

  Widget _productsGridView(List<ProductModel> products) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        itemCount: products.length,
        mainAxisSpacing: 10,
        itemBuilder: (context, index) {
          return singleProductWidget(
            products[index],
            index == (products.length) - 1 ? true : false,
            context,
          );
        },
      ),
    );
  }

  singleProductWidget(
      ProductModel product, bool lastItem, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withOpacity(.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productImage(product),
              Row(
                children: [
                  _productNameAndPrice(product),
                  _favoriteButton(product, context),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              lastItem == true ? MediaQuery.of(context).size.height * 0.15 : 0,
        )
      ],
    );
  }

  Widget _productImage(ProductModel? product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: FadeInImage.assetNetwork(
        placeholder: ImagesAssets.imageLoading,
        image: product?.image ?? Constants.failedToLoadImage,
      ),
    );
  }

  Widget _productNameAndPrice(ProductModel product) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
            child: Text(
              product.name,
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                Text(
                  "\$${product.price.round()}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (product.discount != 0)
                  Text(
                    "\$${product.oldPrice.round()}",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoriteButton(ProductModel product, BuildContext context) {
    return FavoriteButton(
      product: product,
      categoryId: widget.categoryId,
    );
  }

  void _onAddOrDeleteFavoriteSuccessState(state, context) async {
    if(state is AddOrDeleteFavoritesSuccessState){
      BlocProvider.of<FavoritesBloc>(context).add(GetFavoritesEvent());
    }
  }

  void _onAddOrDeleteFavoriteErrorState(
      AddOrDeleteFavoriteState state, BuildContext context) async {
    if (state is AddOrDeleteFavoritesErrorState) {
      Fluttertoast.showToast(
        msg: state.message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.red,
        textColor: ColorManager.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
