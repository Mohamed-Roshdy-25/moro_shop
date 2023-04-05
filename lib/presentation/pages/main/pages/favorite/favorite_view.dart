import 'package:flutter/material.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Card(
            elevation: 10,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Image(
                    fit: BoxFit.cover,
                    image: AssetImage(ImagesAssets.defaultProfilePic),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'dafjkasfka\n\nsdfsdfnsdlglsdg....',
                  style: TextStyle(color: Colors.blue),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
