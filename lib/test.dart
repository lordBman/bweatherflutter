import 'dart:developer';

import 'package:bweatherflutter/services/bridge.dart';
import 'package:bweatherflutter/services/notifications.dart';
import 'package:flutter/material.dart';

void main()async {
    runApp(const App());
}

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return const MaterialApp(
            home: Test(),
        );
    }
}

class Test extends StatelessWidget{
    const Test({ super.key });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: FutureBuilder(future: Bridge.getNativeData(), builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                      return const Text("Loading....");
                  }else if(snapshot.connectionState == ConnectionState.done){
                      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text("${snapshot.hasError ? snapshot.error : snapshot.data}"),
                          ElevatedButton(
                              onPressed: () {
                                  NotificationHelper.showNotification(
                                      'Hello from Flutter',
                                      'This is a notification from native Android code!',
                                  ).catchError((error){
                                      log("notification error", error: error);
                                  }).then((_){
                                      log("notification done");
                                  });
                              },
                              child: const Text('Show Notification'),
                          )
                      ]);
                  }
                  return const Text("No glue what is going on");
                }),
            ),
        );
    }
}