part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarEvent {}

final class SelectOtherPage extends BottomNavBarEvent {
  final int index;

  SelectOtherPage({required this.index});
}

class RefreshPage extends BottomNavBarEvent {
  final int index;
  RefreshPage({required this.index});
}
