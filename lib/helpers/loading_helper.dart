import 'package:flutter/material.dart';
import 'loading_indicators.dart';
import 'navigation_service.dart';

extension Loader on Future {
  Future<dynamic> waitingForSucess() async {
    showDialog(
        context: NavigationService.context,
        builder: (context) => Center(
              child: shimmer(
                context: context,
              ),
            ));
    try {
      // Wait for the original future to complete
      dynamic result = await this;

      return result;
    } finally {
      // Close the loading dialog
      NavigationService.goBack();
    }
  }
}
