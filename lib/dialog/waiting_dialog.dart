import 'package:flutter/material.dart';

class WaitingDialog extends StatefulWidget {
  const WaitingDialog({Key? key}) : super(key: key);

  @override
  _WaitingDialogState createState() => _WaitingDialogState();
}

class _WaitingDialogState extends State<WaitingDialog>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.width * 0.15,
        width: size.width * 0.15,
        padding: EdgeInsets.all(size.width * 0.025),
        child: CircularProgressIndicator(
          valueColor: animationController!.drive(
            ColorTween(begin: Colors.blue.withOpacity(0.5), end: Colors.blue),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue.withOpacity(0.5),
              width: 2,
            ),
            color: Colors.white.withOpacity(0.5)),
      ),
    );
  }
}