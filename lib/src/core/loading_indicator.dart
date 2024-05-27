import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyUtilLoadingIndicator extends StatelessWidget {
  const MyUtilLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRotatingCircle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
