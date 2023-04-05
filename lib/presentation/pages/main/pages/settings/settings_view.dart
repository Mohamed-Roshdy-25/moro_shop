
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/logout/logout_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _buildBody(context, size);
  }

  void _onLogoutError(LogoutState state, BuildContext context ){
    if(state is LogoutErrorState){
      if(state.message == AppStrings.unKnownError){
        BlocProvider.of<LogoutBloc>(context).add(const PostLogoutEvent());
      }else {
        ErrorState(StateRendererType.popupErrorState, state.message).getScreenWidget(context,buttonTitle: AppStrings.retryAgain,retryActionFunction: (){
          BlocProvider.of<LogoutBloc>(context).add(const PostLogoutEvent());
        });
      }
    }
  }

  void _onLogoutSuccess(LogoutState state, BuildContext context ){
    if(state is LogoutSuccessState){
      Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          ModalRoute.withName(Routes.splashRoute));
    }
  }

  void _onLogoutLoading(LogoutState state, BuildContext context ){
    if(state is LogoutLoadingState){
      LoadingState(stateRendererType: StateRendererType.popupLoadingState).getScreenWidget(context);
    }
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
                    _item(
                        icon: FontAwesomeIcons.userPen,
                        title: AppStrings.profile,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profileRoute);
                        }),
                    const Divider(thickness: 4),
                    _item(
                      icon: FontAwesomeIcons.language,
                      title: AppStrings.language,
                      onTap: () {},
                    ),
                    const Divider(thickness: 4),
                    BlocProvider<LogoutBloc>(
                      create: (context) => instance<LogoutBloc>(),
                      child: BlocConsumer<LogoutBloc, LogoutState>(
                        listener: (context, state) {
                          _onLogoutError(state, context);
                          _onLogoutLoading(state, context);
                          _onLogoutSuccess(state, context);
                        },
                        builder: (context, state) {
                          return _item(
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            title: AppStrings.logout,
                            onTap: () {
                              BlocProvider.of<LogoutBloc>(context).add(const PostLogoutEvent());
                            },
                          );
                        },
                      ),
                    ),
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
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
