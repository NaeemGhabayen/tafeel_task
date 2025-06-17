import 'package:flutter/material.dart';
import 'package:tafeel_task/utils/custom_themes.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  final Stream<bool> connectionStatus;

  const NetworkAwareWidget(
      {super.key, required this.child, required this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: connectionStatus,
      builder: (context, snapshot) {
        final isOffline = snapshot.hasData && !snapshot.data!;
        return Stack(
          children: [
            child,
            if (isOffline)
              Positioned(
                left: 0,
                right: 0,
                top: 30,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'No Internet Connection',
                    style: bodyBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
