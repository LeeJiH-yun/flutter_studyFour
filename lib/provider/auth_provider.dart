import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_studyfour/model/user_model.dart';
import 'package:flutter_studyfour/screen/1_screen.dart';
import 'package:flutter_studyfour/screen/2_screen.dart';
import 'package:flutter_studyfour/screen/3_screen.dart';
import 'package:flutter_studyfour/screen/error_screen.dart';
import 'package:flutter_studyfour/screen/home_screen.dart';
import 'package:flutter_studyfour/screen/login_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(ref: ref);

  return GoRouter(
    initialLocation: '/login', //앱 처음 시작시 화면
    errorBuilder: (context, state) {
      //화면 이동시 발생하는 에러처리
      return ErrorScreen(error: state.error.toString()); //에러를 상태로부터 받아올 수 있다.
    },
    //redirect
    //refresh
    routes: authStateProvider._route,
    redirect: authStateProvider._redirectLogic,
    refreshListenable: authStateProvider, //상태가 바꼈을 때(화면 이동은 없지만 토큰이 만료됐다거나, authStateProvider상태가 변경됐을 때) redirect를 재실행 해준다.
  );
});

class AuthNotifier extends ChangeNotifier {
  //로그인 상태가 바꼈을 때
  final Ref ref;

  AuthNotifier({required this.ref}) {
    ref.listen<UserModel?>(
      userProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners(); //상태 변경 시그널
        }
      },
    );
  }

  String? _redirectLogic(GoRouterState state) { //네비게이션이 될 때마다 state가 들어간다.
    //반환값은 이동할 페이지의 이름
    final user = ref.read(userProvider); //UserModel의 인스턴스 또는 null이 들어온다.

    final loggingIn = state.location == '/login'; //로그인을 하려는 상태인지 현재 위치를 가져온다. = location

    if(user == null) {
      //유저 정보가 없다는 것은 로그인한 상태가 아니다와 같다.
      //유저 정보가 없고 로그인하려는 중이 아니라면 로그인 페이지로 이동한다. 만일 로그인 중이면 보내면 안된다.
      return loggingIn ? null : '/login';
    }

    if(loggingIn){
      //유저 정보가 있는데 로그인 페이지라면 홈으로 이동
      return '/';
    }

    return null; //나머지 상태는 원래 가려던 곳으로 리턴..
  }

  List<GoRoute> get _route => [
      GoRoute(path: '/', builder: (_, state) => HomeScreen(), routes: [
        GoRoute(path: 'one', builder: (_, state) => OneScreen(), routes: [
          GoRoute(path: 'two', builder: (_, state) => TwoScreen(), routes: [
            GoRoute(
              path: 'three',
              name: ThreeScreen.routeName,
              //중복되면 안된다. string으로 써도 되긴 하는데 그것보단 이 방법을 선택 (오타방지)
              builder: (_, state) => ThreeScreen(),
            ),
          ]),
        ]),
      ]),
      GoRoute(
        path: '/login',
        builder: (_, state) => LoginScreen(),
      )
  ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
    (ref) => UserStateNotifier());

class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  //로그인한 상태면 UserModel 인스턴스 상태로 넣어주기
  login({required String name}) {
    state = UserModel(name: name);
  }

  //로그아웃 상태면 null상태로 넣어주기
  logout() {
    state = null;
  }
}
