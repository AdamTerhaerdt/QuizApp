import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/topics/topic_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    if (user != null) {
      return Scaffold(
        backgroundColor: Colors.lightBlue[200],
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  user.email ?? 'No email found.',
                  style: Theme.of(context).textTheme.titleLarge,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Quizzes Completed: ${report.total}',
                  style: Theme.of(context).textTheme.titleLarge,
                  textDirection: TextDirection.ltr,
                ),
              ),
              FutureBuilder<List<Topic>>(
                future: FirestoreService().getTopics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      "Something went wrong.",
                      textDirection: TextDirection.ltr,
                    ));
                  } else if (snapshot.hasData) {
                    List<Topic> topics = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                          child: Column(
                        children: topics.map((topic) {
                          if (report.topics.keys
                              .contains(topic.title.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(topic.title + ' - Completed.'),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(topic.title + ' - Not completed yet.'),
                            );
                          }
                        }).toList(),
                      )),
                    );
                  } else {
                    return const Text(
                        'No topics found in Firestore. Check database.',
                        textDirection: TextDirection.ltr);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return Loader();
    }
  }
}
