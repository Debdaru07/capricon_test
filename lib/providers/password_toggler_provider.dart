import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final emailControllerProvider = AutoDisposeProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose()); // Automatically dispose when the provider is no longer used
  return controller;
});

final passwordControllerProvider = AutoDisposeProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose()); // Automatically dispose when the provider is no longer used
  return controller;
});