import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/auth_model.dart';
import '../model/login_auth_model.dart';

class LoginState {
  final bool isLoading;
  final AuthResponse? authResponse;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.authResponse,
    this.error,
  });

  LoginState copyWith({bool? isLoading, AuthResponse? authResponse, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      authResponse: authResponse,
      error: error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> login(String identifier, String password) async {
    log('Login started: $identifier');
    state = LoginState(isLoading: true);
    try {
      final loginAuth = LoginAuth(identifier: identifier, password: password);
      final authResponse = await loginAuth.login();
      log('Login success: ${authResponse.user.fullName}');
      state = LoginState(isLoading: false, authResponse: authResponse);
    } catch (e) {
      log('Login error: $e');
      state = LoginState(isLoading: false, error: e.toString());
    }
  }

  void logout() {
    state = LoginState();
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(loginProvider).authResponse != null;
});