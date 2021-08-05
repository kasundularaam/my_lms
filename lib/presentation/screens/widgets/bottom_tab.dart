import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/home_nav_cubit/home_nav_cubit.dart';

class BottomTab extends StatefulWidget {
  final double height;
  const BottomTab({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: 100.w,
      child: BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, state) {
          if (state is HomeNavInitial) {
            return buildInitState();
          } else if (state is HomeScreenNavigate) {
            if (state.homeNav == HomeNav.toHome) {
              return buildNavState(MyColors.white, MyColors.lightGray);
            } else if (state.homeNav == HomeNav.toProfile) {
              return buildNavState(MyColors.lightGray, MyColors.white);
            } else {
              return buildInitState();
            }
          } else {
            return buildInitState();
          }
        },
      ),
    );
  }

  Widget buildInitState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BottomTabButton(
          color: MyColors.white,
          btnIcon: Icons.home_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toHome),
        ),
        BottomTabButton(
          color: MyColors.lightGray,
          btnIcon: Icons.person_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toProfile),
        ),
      ],
    );
  }

  Widget buildNavState(Color hColor, Color pColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BottomTabButton(
          color: hColor,
          btnIcon: Icons.home_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toHome),
        ),
        BottomTabButton(
          color: pColor,
          btnIcon: Icons.person_rounded,
          onPressed: () => BlocProvider.of<HomeNavCubit>(context)
              .homeNavigate(homeNav: HomeNav.toProfile),
        ),
      ],
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final Color color;
  final IconData btnIcon;
  final Function onPressed;
  const BottomTabButton({
    Key? key,
    required this.color,
    required this.btnIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: 30.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              btnIcon,
              size: 5.5.h,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
