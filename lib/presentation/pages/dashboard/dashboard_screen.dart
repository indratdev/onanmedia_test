import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onanmedia_test/presentation/pages/classroom/classroom_screen.dart';
import 'package:onanmedia_test/presentation/pages/student/student_screen.dart';
import 'package:onanmedia_test/shared/utils/global_variables.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    super.key,
    required this.userProfile,
  });

  User userProfile;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Map<String, dynamic>> listMainMenu;

  @override
  void initState() {
    listMainMenu = initializeListHelpTopic();
    super.initState();
  }

  List<Map<String, dynamic>> initializeListHelpTopic() {
    return [
      {
        "title": "Kelas",
        "icon": Icons.class_,
        "onTap": () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClassRoomScreen(),
              ),
            )
      },
      {
        "title": "Mahasiswa",
        "icon": Icons.people,
        "onTap": () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentScreen(),
              ),
            )
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    double _widht = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Icon(Icons.person),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userProfile.email ?? "No Name",
              style: TextStyle(
                fontSize: _widht * 0.05,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    "https://ugm.ac.id/wp-content/uploads/2023/04/About-Hero.jpg",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.fill,
                    opacity: const AlwaysStoppedAnimation(.9),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 80,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: listMainMenu.length,
                  itemBuilder: (BuildContext ctx, index) {
                    Map<String, dynamic> data = listMainMenu[index];
                    return InkWell(
                      onTap: data["onTap"],
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 4),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.3),
                                  // color: GlobalVariables.baseColor).withOpacity(.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(data["icon"]),
                              ),
                              Text(data["title"]),
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
