part of 'bottom_nav_bar_bloc.dart';

@immutable
sealed class BottomNavBarAdminEvent {}

final class SelectOtherPage extends BottomNavBarAdminEvent {
  final int index;

  SelectOtherPage({required this.index});
}

class RefreshPage extends BottomNavBarAdminEvent {
  final int index;
  RefreshPage({required this.index});
}
