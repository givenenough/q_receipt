import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../flutter_flow_theme.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier, SharedPreferences prefs) {
  final String? accessToken = prefs.getString('accessToken');
  String initialRoute = accessToken != null && accessToken.isNotEmpty ? '/HomePage' : '/LoginPage';
  print(accessToken);
  return GoRouter(
    initialLocation: initialRoute,
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    errorBuilder: (context, _) => LoginPageWidget(),
    routes: [
      FFRoute(
        name: '_initialize',
        path: '/',
        builder: (context, _) => LoginPageWidget(),
        routes: [
          FFRoute(
            name: 'RegisterPage',
            path: 'registerPage',
            builder: (context, params) => RegisterPageWidget(),
          ),
          FFRoute(
            name: 'HomePage',
            path: 'homePage',
            builder: (context, params) {
              final String? accessToken = params.getParam('accessToken', ParamType.String) ?? prefs.getString('accessToken');
              return HomePageWidget(
                accessToken: accessToken,
              );
            }
          ),
          FFRoute(
            name: 'CreateProfile',
            path: 'createProfile',
            builder: (context, params) => CreateProfileWidget(
              token: params.getParam('token', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'LoginPage',
            path: 'loginPage',
            builder: (context, params) => LoginPageWidget(),
          ),
          FFRoute(
            name: 'ReceiptsPage',
            path: 'receiptsPage',
            builder: (context, params) => ReceiptsPageWidget(
              token: params.getParam('token', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'TransactionPage',
            path: 'transactionPage',
            builder: (context, params) => TransactionPageWidget(
              token: params.getParam('token', ParamType.String),
              uuid: params.getParam('uuid', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'GeneratedReceiptPage',
            path: 'generatedReceiptPage',
            builder: (context, params) => GeneratedReceiptPageWidget(
              receipt: params.getParam('receipt', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'ConfirmCodePage',
            path: 'confirmCodePage',
            builder: (context, params) => ConfirmCodePageWidget(
              email: params.getParam('email', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'AnalyticsPage',
            path: 'analyticsPage',
            builder: (context, params) => AnalyticsPageWidget(
              token: params.getParam('token', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'ForgotPasswordPage',
            path: 'forgotPasswordPage',
            builder: (context, params) => ForgotPasswordPageWidget(),
          ),
          FFRoute(
            name: 'ConfirmRecoveryPage',
            path: 'confirmRecoveryPage',
            builder: (context, params) => ConfirmRecoveryPageWidget(
              email: params.getParam('email', ParamType.String),
            ),
          ),
          FFRoute(
            name: 'ChangePasswordPage',
            path: 'changePasswordPage',
            builder: (context, params) => ChangePasswordPageWidget(
              email: params.getParam('email', ParamType.String),
            ),
          )
        ].map((r) => r.toRoute(appStateNotifier)).toList(),
      ),
    ].map((r) => r.toRoute(appStateNotifier)).toList(),
    urlPathStrategy: UrlPathStrategy.path,
  );
}

GoRouter createRouterMod(AppStateNotifier appStateNotifier, bool isLogged) => GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  refreshListenable: appStateNotifier,
  errorBuilder: (context, _) => LoginPageWidget(),
  routes: [
    FFRoute(
      name: '_initialize',
      path: '/',
      builder: (context, _) => LoginPageWidget(),
      routes: [
        FFRoute(
          name: 'RegisterPage',
          path: 'registerPage',
          builder: (context, params) => RegisterPageWidget(),
        ),
        FFRoute(
          name: 'HomePage',
          path: 'homePage',
          builder: (context, params) => HomePageWidget(
            accessToken: params.getParam('accessToken', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'CreateProfile',
          path: 'createProfile',
          builder: (context, params) => CreateProfileWidget(
            token: params.getParam('token', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'LoginPage',
          path: 'loginPage',
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: 'ReceiptsPage',
          path: 'receiptsPage',
          builder: (context, params) => ReceiptsPageWidget(
            token: params.getParam('token', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'TransactionPage',
          path: 'transactionPage',
          builder: (context, params) => TransactionPageWidget(
            token: params.getParam('token', ParamType.String),
            uuid: params.getParam('uuid', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'GeneratedReceiptPage',
          path: 'generatedReceiptPage',
          builder: (context, params) => GeneratedReceiptPageWidget(
            receipt: params.getParam('receipt', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'ConfirmCodePage',
          path: 'confirmCodePage',
          builder: (context, params) => ConfirmCodePageWidget(
            email: params.getParam('email', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'AnalyticsPage',
          path: 'analyticsPage',
          builder: (context, params) => AnalyticsPageWidget(
            token: params.getParam('token', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'ForgotPasswordPage',
          path: 'forgotPasswordPage',
          builder: (context, params) => ForgotPasswordPageWidget(),
        ),
        FFRoute(
          name: 'ConfirmRecoveryPage',
          path: 'confirmRecoveryPage',
          builder: (context, params) => ConfirmRecoveryPageWidget(
            email: params.getParam('email', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'ChangePasswordPage',
          path: 'changePasswordPage',
          builder: (context, params) => ChangePasswordPageWidget(
            email: params.getParam('email', ParamType.String),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    ),
  ].map((r) => r.toRoute(appStateNotifier)).toList(),
  urlPathStrategy: UrlPathStrategy.path,
);

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (GoRouter.of(this).routerDelegate.matches.length <= 1) {
      go('/');
    } else {
      pop();
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
