part of 'theam_bloc.dart';

abstract class TheamEvent {}

class ThemeChangedEvent extends TheamEvent {
  final bool isDark;

  ThemeChangedEvent(this.isDark);
}
