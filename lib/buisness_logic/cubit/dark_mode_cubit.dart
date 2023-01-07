import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeState(ThemeData.light()));

  void toggleDarkMode(bool isDarkMode) {
    isDarkMode
        ? emit(DarkModeState(ThemeData.dark()))
        : emit(DarkModeState(ThemeData.light()));
  }
}
