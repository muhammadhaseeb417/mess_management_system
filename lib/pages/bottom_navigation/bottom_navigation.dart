import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom_nav_bar_bloc.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.index,
            onDestinationSelected: (value) {
              context
                  .read<BottomNavBarBloc>()
                  .add(SelectOtherPage(index: value));
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                  label: "Admin"),
              NavigationDestination(
                  icon: Icon(Icons.schedule_outlined), label: "Set schedule"),
            ],
          ),
          body: state.screens[state.index],
        );
      },
    );
  }
}
