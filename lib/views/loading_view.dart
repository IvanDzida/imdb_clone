import 'package:flutter/material.dart';

import '../core/configs/styles/app_strings.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 16,
          ),
          Text(
            AppStrings.loading,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
