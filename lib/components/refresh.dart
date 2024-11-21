import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class Refresh extends StatelessWidget{
    final Future<bool> Function() refresh;
    final String image;
    final Widget child;

    const Refresh({ super.key, required this.image, required this.refresh, required this.child });

    @override
    Widget build(BuildContext context) {
        return PullToRefreshNotification(pullBackOnRefresh: false,
          onRefresh: refresh, pullBackCurve: Curves.easeInOut,
          child: CustomScrollView(slivers: <Widget>[
              PullToRefreshContainer((info){
                  var offset = info?.dragOffset ?? 0.0;

                  return SliverToBoxAdapter(
                      child: Lottie.asset(image, height: 0.0 + offset, width: double.infinity, fit: BoxFit.fitHeight),
                  );
              }),
              SliverToBoxAdapter(child: child,)
          ]),
        );
    }
}