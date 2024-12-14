import 'package:bloc/bloc.dart'; // Import your new page
import 'package:flutter/material.dart';
import 'package:mess_management_system/pages/user%20mess%20preperence/user_mess_preference.dart';

import '../../admin_panel/admin_dashboard_rachna.dart';
import '../../user_panel/user_dashboard.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc()
      : super(BottomNavBarState(
          index: 0,
          screens: [
            const UserDashboard(),
            const AdminDashboardRachna(),
            const UserMessPreference(),
          ],
        )) {
    on<SelectOtherPage>((event, emit) {
      emit(
        BottomNavBarState(index: event.index, screens: state.screens),
      );
    });
  }
}
