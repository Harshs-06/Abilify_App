import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/customs/upcoming_events_widget.dart';
import 'package:abilify/customs/device_dimensions.dart';
import 'package:abilify/customs/action_button_widget.dart';
import 'package:abilify/customs/loading_screen.dart';
import 'package:abilify/widgets/bottom_navigation.dart';
import 'package:abilify/pages/ParentSide/community_events.dart';

// Add imports for other pages that will be accessed from navigation bar
// Add these as needed based on your file structure
// import 'package:abilify/pages/ParentSide/service_directory.dart';
// import 'package:abilify/pages/ParentSide/community_forum.dart';
// import 'package:abilify/pages/ParentSide/chats.dart';

final String profile_img = "assets/profile_p2.png";

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  _Parent_hpage createState() => _Parent_hpage();
}

class _Parent_hpage extends State<ParentHomePage> {
  final String parent_name = "Palak";
  final String child_name = "Jai";
  int _currentIndex = 0;

  Map<String, String> moodMap = {
    "assets/dailymood/smileunselec.png":
        "Feeling great? Share it with others and spread the joy!",
    "assets/dailymood/happyunselec.png":
        "You're happy! Keep smiling all day long!",
    "assets/dailymood/sadunselec.png":
        "Feeling down? It's okay to have sad days.",
    "assets/dailymood/depressedunselec.png":
        "If you're feeling low, talk to someone you trust.",
  };

  String? selectedPath;

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      
      // Navigate to different pages based on tab index
      switch (index) {
        case 1:
          Navigator.pushReplacementNamed(context, '/service_directory');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/community_forum');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/chats');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = getDevice_wh(context)[0];
    final deviceHeight = getDevice_wh(context)[1];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, $parent_name!",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "How are you and $child_name doing today?",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: ClipOval(
                            child: Image.asset(profile_img, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceHeight * 0.01),
                SizedBox(
                  width: deviceWidth * 0.85,
                  height: deviceHeight * 0.08,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBar(
                      leading: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 44, 44, 44),
                      ),
                      hintText: 'Search',
                      textStyle: WidgetStatePropertyAll(
                        GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 44, 44, 44),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      shadowColor: WidgetStateProperty.all(Colors.black),
                      elevation: WidgetStateProperty.all(0.5),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: deviceHeight * 0.03),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                        child: Text(
                          "Daily mood log",
                          style: GoogleFonts.titilliumWeb(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.899,
                      height: deviceHeight * 0.08,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 233, 213, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (selectedPath != null)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        selectedPath!,
                                        width: 36,
                                        height: 36,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        moodMap[selectedPath!]!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          if (selectedPath == null)
                            ...moodMap.entries.map((entry) {
                              final path = entry.key;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPath = path;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  width: 40,
                                  height: 40,
                                  child: ClipOval(
                                    child: Image.asset(path, fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.03),

                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Quick Actions",
                          style: GoogleFonts.titilliumWeb(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(16, 15, 15, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.4,

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      actionsButton(
                        "Events",
                        "assets/eventsicon.png",
                        () => navigateWithLoading(
  context,
  CommunityEvents(),
  () async {
    await Future.delayed(Duration(seconds: 2)); 
  },
)

                      ),
                      actionsButton(
                        "Polls & Discussions",
                        "assets/pollsicon.png",
                        () {},
                      ),
                      actionsButton(
                        "Progress Tracking",
                        "assets/progressicon.png",
                        () {},
                      ),
                      actionsButton(
                        "Buddy Program",
                        "assets/buddyicon.png",
                        () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceHeight * 0.03),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 16),
                        child: Text(
                          "Upcoming Events",
                          style: GoogleFonts.titilliumWeb(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(29, 28, 28, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                upcomingeventslist(
                  "assets/parentsupport.png",
                  "Parent Support Group",
                  "10:00 AM",
                  "Community Centre, 123 Church Street",
                  deviceWidth,
                  deviceHeight,
                ),

                upcomingeventslist(
                  "assets/workshop.png",
                  "IEP Workshop",
                  "7:00 AM",
                  "Virtual Meeting (Zoom)",
                  deviceWidth,
                  deviceHeight,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AbilifyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
