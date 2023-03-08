import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/style_manager.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final String? searchBarTitle;
  const CustomAppBar({Key? key, required this.title, this.searchBarTitle})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        //title

        Row(
            children: [
              Text(
                widget.title,
                style: StyleManager.titleStyle.copyWith(
                    color: ColorManager.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.grey.withOpacity(.2),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Icon(
                      FontAwesomeIcons.bell,
                      color: ColorManager.primary,
                      size: 20,
                    ),
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: ColorManager.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),



        //search bar

        if(widget.searchBarTitle != null)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.searchengin),
                const SizedBox(width: 10,),
                Text(widget.searchBarTitle!)
              ],
            ),
          ),
      ],
    );
  }
}
