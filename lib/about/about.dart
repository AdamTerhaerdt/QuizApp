import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/about/about_state.dart';
import 'package:myapp/services/models.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final programmingLanguages = [
      "Python",
      "Dart",
      "C",
      "Java",
      "JavaScript",
      "HTML",
      "CSS",
      "React-Native"
    ];
    return ChangeNotifierProvider(
        create: (_) => AboutState(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('About'),
            ),
            body: Consumer<AboutState>(builder: (context, state, _) {
              return ListView(children: [
                ExpansionPanelList(
                  elevation: 1,
                  expansionCallback: (int index, bool isExpanded) {
                    state.toggleExpansion(index);
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, state) {
                        return const ListTile(
                          leading: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.person),
                          ),
                          title: Text("About Me",
                              style: TextStyle(color: Colors.white)),
                        );
                      },
                      body: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: const Text(
                            "My name is Adam and I am using this app to learn Flutter. I am a 4th year Software Engineering student who is passionate about mobile development. I have always been intrigued by the power of mobile applications and their ability to make a significant impact on people's lives. In addition to using this app to learn Flutter, I am also leveraging this project as a means to gain practical knowledge and skills for building a mobile app specifically tailored for a local coffee company. As a passionate software engineering student, I believe that applying my learning to real-world scenarios is essential for honing my abilities and making a tangible impact.",
                          ),
                        ),
                      ),
                      isExpanded: state.isExpanded(0),
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          leading: Icon(
                            Icons.code,
                            color: Colors.white,
                          ),
                          title: Text("Programming Languages",
                              style: TextStyle(color: Colors.white)),
                        );
                      },
                      body: ListTile(
                        title: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            "Dart\nPython\nC\nJava\nJavaScript\nHTML\nCSS\nReact-Native",
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ),
                      isExpanded: state.isExpanded(1),
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          title: Text("Contact Me",
                              style: TextStyle(color: Colors.white)),
                        );
                      },
                      body: ListTile(
                        title: Text("Email: Adam.terhaerdt1@gmail.com"),
                      ),
                      isExpanded: state.isExpanded(2),
                    ),
                  ],
                ),
                Image.asset('assets/congrats.gif'),
              ]);
            })));
  }
}
