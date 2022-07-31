import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:patoapp/themes/light_theme.dart';

class ModalFitTimeOut extends StatelessWidget {
  const ModalFitTimeOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: <Widget>[
              const Icon(Icons.error, size: 30, color: patowaveErrorRed),
              Container(width: 15),
              const Expanded(
                child: Text(
                    "Time out, try checking your internent connection and try again"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class FloatingModalTimeOut extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModalTimeOut(
      {Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(15),
          child: child,
        ),
      ),
    );
  }
}

Future<T> showTimeOutMessage<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => FloatingModalTimeOut(
            child: child,
          ),
      expand: false);

  return result;
}
