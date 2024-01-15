import 'package:flutter/material.dart';
import 'package:w_sentry/res/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.color, this.size = 48}) : super(key: key);

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        height: size,
        width: size,
        // child: Platform.isIOS
        //     ? CupertinoActivityIndicator(
        //         color: color ?? AppColors.primary1,
        //       )
        //     : CircularProgressIndicator(
        //         valueColor: AlwaysStoppedAnimation<Color>(
        //           color ?? AppColors.primary1,
        //         ),
        //       ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
