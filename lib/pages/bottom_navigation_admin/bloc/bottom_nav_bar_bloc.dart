import 'package:bloc/bloc.dart'; // Import your new page
import 'package:flutter/material.dart';
import 'package:mess_management_system/pages/admin_dashboard/admin_dashboard.dart';
import 'package:mess_management_system/pages/setting/setting_admin.dart';
import 'package:mess_management_system/pages/setting/setting_page.dart';
import 'package:mess_management_system/pages/user%20mess%20preperence/user_mess_preference.dart';

import '../../admin_panel/admin_dashboard_rachna.dart';
import '../../user_panel/user_dashboard.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarAdminBloc
    extends Bloc<BottomNavBarAdminEvent, BottomNavBarAdminState> {
  BottomNavBarAdminBloc()
      : super(BottomNavBarAdminState(
          index: 0,
          screens: [
            const AdminDashboard(),
            const AdminDashboardRachna(),
            const SettingAdminPage(),
          ],
        )) {
    on<SelectOtherPage>((event, emit) {
      emit(
        BottomNavBarAdminState(index: event.index, screens: state.screens),
      );
    });
  }
}
