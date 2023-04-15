import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:moro_shop/presentation/bloc/add_delete_favorite/add_or_delete_favorite_bloc.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';

class FavoriteButton extends StatefulWidget {
  final dynamic product;
  final int categoryId;

  const FavoriteButton(
      {Key? key, required this.product, required this.categoryId})
      : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider.of<AddOrDeleteFavoriteBloc>(context)
              .isFavoriteProductLoading[(widget.product.id)]
              .orFalse()
          ? SizedBox(
              height: 30,
              width: 30,
              child: Lottie.asset(JsonAssets.loading),
            )
          : GestureDetector(
              onTap: () {
                BlocProvider.of<AddOrDeleteFavoriteBloc>(context).add(
                    PostAddOrDeleteFavoritesEvent(
                        widget.product.id, widget.categoryId.toString()));
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: BlocProvider.of<AddOrDeleteFavoriteBloc>(context)
                                  .inFavorites[widget.product.id] ??
                              false
                          ? [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).primaryColor,
                            ]
                          : [
                              ColorManager.grey,
                              ColorManager.grey,
                            ],
                    ),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  FontAwesomeIcons.heartPulse,
                  size: 15,
                  color: ColorManager.white,
                ),
              ),
            ),
    );
  }
}
