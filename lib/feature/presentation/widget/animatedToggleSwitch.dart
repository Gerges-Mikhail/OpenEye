// import 'package:flutter/material.dart';
// import 'package:animated_toggle_switch/animated_toggle_switch.dart';
// import 'package:open_eye/feature/presentation/common/colors/colors.dart';
//
// class AnimatedToggleSwitch extends StatelessWidget {
//   const AnimatedToggleSwitch.dual({
//     Key? key, required bool first, required current, required bool second, required bool loading, required double dif, required Color borderColor, required double borderWidth, required int height, required onChanged,
//   }) : super(key: key);
//   bool? current = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedToggleSwitch.dual(
//       current: false,
//       first: false,
//       second: true,
//       loading: false,
//       dif: 50.0,
//       borderColor: Colors.transparent,
//       borderWidth: 5.0,
//       height: 55,
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black26,
//           spreadRadius: 1,
//           blurRadius: 2,
//           offset: Offset(0, 1.5),
//         ),
//       ],
//       onChanged:
//       //     (b) {
//       //   setState(() => positive = b);
//       //   return Future.delayed(Duration(seconds: 1));
//       // },
//       colorBuilder:
//         // (b) => b ? primaryColor : primaryColor,
//       iconBuilder: (value) => value
//           ? Icon(Icons.arrow_forward)
//           : Icon(Icons.arrow_back),
//       textBuilder: (value) => value
//           ? Center(child: Text('Double Click on screen'))
//           : Center(child: Text('Double click on power button')),
//     );
//   }
// }
