import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:myapp/services/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/shared/progress_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Topic> topics = Provider.of<List<Topic>>(context);
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    if (user != null) {
      return Scaffold(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: topics.map((topic) {
                      if (report.topics[topic.id] != null &&
                          report.topics[topic.id].length ==
                              topic.quizzes.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(topic.title + ' - Completed!'),
                                  Icon(
                                    FontAwesomeIcons.award,
                                    size: 20,
                                  ),
                                ],
                              ),
                              AnimatedProgressbar(
                                value: report.topics[topic.id].length /
                                    topic.quizzes.length,
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(topic.title + ' - Not completed yet.'),
                              if (report.topics[topic.id] != null)
                                AnimatedProgressbar(
                                  value: report.topics[topic.id].length /
                                      topic.quizzes.length,
                                  height: 20,
                                )
                              else
                                AnimatedProgressbar(
                                  value: 0,
                                  height: 20,
                                ),
                            ],
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Loader();
    }
  }
}
