// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:layout/API/github_api.dart';
import 'widgets/user.dart';
import 'widgets/inputBox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('GitHub Users'),
          ),
          body: Center(
            child: Column(
              children: [
                Container(height: 80, width: 500, child: InputForm()),
                Expanded(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: GitHubApi().getRandomUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 10),
                              child: User(
                                userName: snapshot.data?[index]['login'],
                                avatarUrl: snapshot.data?[index]['avatar_url'],
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ))
              ],
            ),
          )),
    );
  }
}
