import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'theam_event.dart';

class TheamBloc extends Bloc<TheamEvent, ThemeMode> {
  TheamBloc() : super(ThemeMode.light) {
    on<ThemeChangedEvent>((event, emit) {
      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
