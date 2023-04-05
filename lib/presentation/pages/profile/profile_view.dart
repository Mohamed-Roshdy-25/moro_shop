import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/profile/profile_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/style_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void _onProfileDataError(ProfileState state, BuildContext context) {
    if (state is GetProfileErrorState) {
      if (state.message == AppStrings.unKnownError) {
        BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => instance<ProfileBloc>()..add(GetProfileEvent()),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            _onProfileDataError(state, context);
          },
          builder: (context, state) {
            if (state is GetProfileSuccessState) {
              var data = state.profileModel.userDataModel;

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    const SizedBox(
                      height: 100,
                      child: AuthHeaderWidget(100, false),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 5, color: Colors.white),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: data?.image != null && data!.image.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                    height: 80,
                                    width: 80,
                                    placeholder: ImagesAssets.imageLoading,
                                    image: data.image,
                                    fit: BoxFit.fill,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey.shade300,
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            data?.name ?? '',
                            style: StyleManager.bodyStyle
                                .copyWith(color: ColorManager.primary),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 4.0),
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "My Information",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Card(
                                  elevation: 30,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            ...ListTile.divideTiles(
                                              color: Colors.grey,
                                              tiles: [
                                                const ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                  leading:
                                                      Icon(Icons.my_location),
                                                  title: Text("Location"),
                                                  subtitle: Text("EGY"),
                                                ),
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.email),
                                                  title: const Text("Email"),
                                                  subtitle:
                                                      Text(data?.email ?? ''),
                                                ),
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.phone),
                                                  title: const Text("Phone"),
                                                  subtitle:
                                                      Text(data?.phone ?? ''),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is GetProfileErrorState) {
              return ErrorState(
                      StateRendererType.fullScreenErrorState, state.message)
                  .getScreenWidget(context, buttonTitle: AppStrings.retryAgain,
                      retryActionFunction: () {
                dismissDialog(context);
                BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
              });
            } else {
              return LoadingState(
                      stateRendererType:
                          StateRendererType.fullScreenLoadingState)
                  .getScreenWidget(context);
            }
          },
        ),
      ),
    );
  }
}
