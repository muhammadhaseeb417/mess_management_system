import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom_nav_bar_bloc.dart';

class BottomNavigationAdmin extends StatelessWidget {
  const BottomNavigationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarAdminBloc, BottomNavBarAdminState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.index,
            onDestinationSelected: (value) {
              context
                  .read<BottomNavBarAdminBloc>()
                  .add(SelectOtherPage(index: value));
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Dashboard"),
              NavigationDestination(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                  label: "Add Meal"),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: "Setting"),
            ],
          ),
          body: state.screens[state.index],
        );
      },
    );
  }
}
