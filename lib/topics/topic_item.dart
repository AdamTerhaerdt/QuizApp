import 'package:flutter/material.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/shared/progress_bar.dart';
import 'package:myapp/topics/drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: topic.img,
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TopicsScreen(topic: topic),
                    ),
                  );
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          child: Image.asset(
                            'assets/covers/${topic.img}',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            topic.title,
                            style: const TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                      ),
                      Flexible(child: TopicProgress(topic: topic)),
                    ]))));
  }
}

class TopicsScreen extends StatelessWidget {
  final Topic topic;
  const TopicsScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            Hero(
              tag: topic.img,
              child: Image.asset('assets/covers/${topic.img}',
                  width: MediaQuery.of(context).size.width),
            ),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 20,
                height: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            QuizList(topic: topic)
          ],
        ));
  }
}
