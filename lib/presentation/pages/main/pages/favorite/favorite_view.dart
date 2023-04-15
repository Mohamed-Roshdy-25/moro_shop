import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:moro_shop/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/font_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/style_manager.dart';


class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _favoritesBlocProviders(),
      child: _body(context),
    );
  }

  _favoritesBlocProviders() => [
        BlocProvider(
          create: (context) =>
              instance<FavoritesBloc>()..add(GetFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => instance<DeleteFavoriteBloc>(),
        ),
      ];

  Widget _body(context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        _onFavoritesSuccessState(state, context);
      },
      builder: (context, state) {
        List<FavoriteProductModel>? favoriteItems =
            BlocProvider.of<FavoritesBloc>(context).favorites;

        if (favoriteItems != null) {
          if (favoriteItems.isNotEmpty) {
            return _successGetFavorites(favoriteItems);
          } else {
            return _emptyFavorite();
          }
        } else if (state is GetFavoritesErrorState) {
          return _errorGetFavorites(state, context);
        } else if (state is FavoritesInitial) {
          return Container();
        } else {
          return _loadingGetFavorites(context);
        }
      },
    );
  }

  void _onFavoritesSuccessState(state, context) {
    if (state is GetFavoritesSuccessState) {
      for (FavoriteProductModel element in state.favoritesAllDataModel
              .favoriteAllProductsDataModel?.favoriteProducts ??
          []) {
        BlocProvider.of<DeleteFavoriteBloc>(context)
            .isFavoritesProductLoading
            .addAll({
          element.favoriteId: element.product.isLoading,
        });
      }
    }
  }

  Widget _successGetFavorites(favoriteItems) {
    return BlocConsumer<DeleteFavoriteBloc, DeleteFavoriteState>(
      listener: (context, state) {
        _onDeleteFavoriteSuccessState(state, context);
        _onDeleteFavoriteErrorState(state, context);
      },
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            ProductModel product = favoriteItems[index].product;
            return _favoriteItem(index, favoriteItems, product, context);
          },
        );
      },
    );
  }

  void _onDeleteFavoriteErrorState(state, context) {
    if (state is DeleteFavoriteErrorState) {
      Fluttertoast.showToast(
        msg: state.message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.red,
        textColor: ColorManager.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void _onDeleteFavoriteSuccessState(state, context) {
    if (state is DeleteFavoriteSuccessState) {
      BlocProvider.of<FavoritesBloc>(context).add(GetFavoritesEvent());
    }
  }

  Widget _favoriteItem(index, favoriteItems, product, context) {
    return Column(
      children: [
        _itemData(index, favoriteItems, product, context),
        if (index == favoriteItems.length - 1)
          const SizedBox(
            height: 120,
          )
      ],
    );
  }

  Widget _itemData(index, favoriteItems, product, context) {
    return Stack(
      children: [
        _productInformation(index, favoriteItems, product, context),
        _favoriteItemImage(product),
      ],
    );
  }

  Widget _productInformation(index, favoriteItems, product, context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productNameDescriptionPrice(product),
            const Spacer(),
            _deleteButton(index, favoriteItems, context),
          ],
        ),
      ),
    );
  }

  Widget _productNameDescriptionPrice(product) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: StyleManager.titleStyle.copyWith(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.description,
            style: StyleManager.bodyStyle.copyWith(color: Colors.black54),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                "\$${product.price.toString()}",
                style: StyleManager.bodyStyle
                    .copyWith(color: Colors.black, fontSize: FontSize.s12),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 20,
              ),
              if (product.discount != 0)
                Text(
                  "\$${product.oldPrice.toString()}",
                  style: StyleManager.bodyStyle.copyWith(
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                      fontSize: FontSize.s12),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _favoriteItemImage(product) {
    return Positioned(
      bottom: 0,
      right: 15,
      child: Container(
        height: 130,
        width: 130,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FadeInImage.assetNetwork(
          placeholder: ImagesAssets.imageLoading,
          image: product.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _deleteButton(index, favoriteItems, context) {
    bool isLoading = BlocProvider.of<DeleteFavoriteBloc>(context)
        .isFavoritesProductLoading[favoriteItems[index].favoriteId]
        .orFalse();

    return isLoading
        ? SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset(JsonAssets.loading),
          )
        : GestureDetector(
            onTap: () {
              BlocProvider.of<DeleteFavoriteBloc>(context).add(
                  PostDeleteFavoriteEvent(favoriteItems[index].favoriteId));
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.xmark,
                size: 15,
                color: ColorManager.white,
              ),
            ),
          );
  }

  Widget _errorGetFavorites(state, context) {
    return ErrorState(StateRendererType.fullScreenErrorState, state.message)
        .getScreenWidget(context, buttonTitle: AppStrings.retryAgain,
            retryActionFunction: () {
      BlocProvider.of<FavoritesBloc>(context).add(GetFavoritesEvent());
    });
  }

  Widget _emptyFavorite() {
    return Center(
      child: Text(
        'No Favorite Items',
        style: StyleManager.titleStyle.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _loadingGetFavorites(context) {
    return LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState)
        .getScreenWidget(context);
  }
}
