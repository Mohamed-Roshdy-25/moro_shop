import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/data/data_sources/local_data_source.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _buildBody(context, size);
  }

  _buildBody(context, size) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    _item(icon: FontAwesomeIcons.userPen, title: AppStrings.profile,onTap: (){
                      Navigator.pushNamed(context, Routes.profileRoute);
                    }),
                    const Divider(thickness: 4,),
                    _item(icon: FontAwesomeIcons.language, title: AppStrings.language,onTap: (){}),
                    const Divider(thickness: 4,),
                    _item(icon: FontAwesomeIcons.arrowRightFromBracket, title: AppStrings.logout,onTap: (){
                      _logout();
                    },),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  _item({
    required IconData icon,
    required String title,
    required Function() onTap,
}){
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Icon(icon,color: Colors.blue,),
                const SizedBox(width: 30,),
                Text(title),
              ],
            ),
          ),
        ),
      ],
    );
  }


  _logout() {
    _appPreferences.logout().then((value) {
      _localDataSource.clearCache();
      Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, ModalRoute.withName(Routes.splashRoute));
    });
  }
}
