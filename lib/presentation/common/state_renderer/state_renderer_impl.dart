import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popup, full_screen)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// success state (popup)

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessState;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  getScreenWidget(context, {Function? retryActionFunction,String buttonTitle = Constants.empty,}) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          _showPopup(context, getStateRendererType(), message: getMessage());
        } else {
          return StateRenderer(stateRendererType: getStateRendererType());
        }
        break;
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          _showPopup(context, getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle);
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
        break;
      case SuccessState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupSuccessState) {
          _showPopup(context, getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle,);
        } else {
          return StateRenderer(stateRendererType: getStateRendererType());
        }
    }
  }

  _showPopup(
    BuildContext context,
    StateRendererType stateRendererType, {
    String? message,
    String title = Constants.empty,
    Function? retryActionFunction,
    String buttonTitle = Constants.empty,
  }) {
    SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message ?? AppStrings.loading,
              title: title,
              retryActionFunction: retryActionFunction ?? () {},
              buttonTitle: buttonTitle,
            )));
  }
}

_isCurrentDialogShowing(context) => ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  });
}
