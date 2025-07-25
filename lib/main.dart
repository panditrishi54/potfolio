import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rishi Bhardwaj',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PortfolioHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Five tabs: Home, About Me, Resume, Project, Contact Me.
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rishi Bhardwaj',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.white, // Set text color for better visibility
            ),
          ),
          backgroundColor: Colors.blueAccent, // Set app bar background color
          centerTitle: true, // Center the title
          elevation: 4, // Add shadow effect
          toolbarHeight: 70, // Set app bar height
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(60), // Adjust tab height
            child: TabBar(
              isScrollable: false, // Ensures tabs are spread evenly
              indicatorColor: Colors.white, // Set active tab underline color
              labelColor: Colors.white, // Active tab text color
              unselectedLabelColor: Colors.black87, // Inactive tab text color
              labelPadding: EdgeInsets.symmetric(horizontal: 20),
              tabs: [

            Tab(child: Text('Home', style: TextStyle(fontSize: 20))), // Set font size
          Tab(child: Text('About Me', style: TextStyle(fontSize: 20))),
          Tab(child: Text('Resume', style: TextStyle(fontSize: 20))),
          Tab(child: Text('Project', style: TextStyle(fontSize: 20))),
          Tab(child: Text('Contact Me', style: TextStyle(fontSize: 20))),
          ],
            ),
          ),
        ),
        body: Container(
          width: double.infinity, // Full width
          height: double.infinity,
          // Full height
          color: Colors.grey[200], // Set background color
          child: const TabBarView(
            children: [
              HomeSection(),
              AboutMeSection(),
              ResumeSection(),
              ProjectSection(),
              ContactMeSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _circleAnimationController;
  late Animation<double> _circleAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 3).animate(_fadeController);
    _fadeController.forward();

    // Background Circle Animation
    _circleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _circleAnimation = Tween<double>(begin: 0, end: pi * 2).animate(_circleAnimationController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _circleAnimationController.dispose();
    super.dispose();
  }

  // Function to Show Contact Options
  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Get in Touch",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildContactTile(FontAwesomeIcons.envelope, "Email Me", "panditrishi54@gmail.com",
                  "mailto:panditrishi54@gmail.com"),
              _buildContactTile(FontAwesomeIcons.whatsapp, "WhatsApp", "+91 8006028218",
                  "https://wa.me/918006028218?text=Hello%20Rishi!"),
              _buildContactTile(FontAwesomeIcons.linkedin, "LinkedIn", "linkedin.com/in/rishi-bhardwaj",
                  "https://www.linkedin.com/in/rishi-bhardwaj-166116249"),
              _buildContactTile(FontAwesomeIcons.instagram, "Instagram", "@rishi_bhardwaj_52",
                  "https://www.instagram.com/rishi_bhardwaj_52"),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle, String url) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint("Could not open $url");
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Stack(
    children: [
    // Animated Background Circles
    Positioned.fill(
    child: AnimatedBuilder(
    animation: _circleAnimation,
    builder: (context, child) {
      return CustomPaint(
        painter: BackgroundCirclePainter(_circleAnimation.value),
      );
    },
    ),
    ),
      Positioned(
        bottom: 20, // Distance from bottom
        right: 20,  // Distance from right
        child: GestureDetector(
          onTap: () => _showContactOptions(context),
          child: const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),








      // Main UI Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Side - Profile Picture (Rectangle)
                    Container(
                      width: constraints.maxWidth * 0.26, // 35% of screen width
                      height: 700, // Fixed height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), // Rounded rectangle
                        image: const DecorationImage(
                          image: AssetImage('assets/img/aa11.jpg'), // Your profile image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24), // Space between image and text

                    // Right Side - Information
                    // Right Side - Information
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, I am Rishi Bhardwaj!',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '• Passionate Software Developer specializing in Flutter, Firebase, and UI/UX design.\n'
                                  '• Expertise in Python, Java, and IoT solutions.\n'
                                  '• Proficient in building innovative, efficient applications to solve real-world problems.\n'
                                  '• Experienced in developing automation and responsive web-based systems to enhance efficiency and user experience.\n'
                                  '• .\n'
                                  '• Skilled in Firebase and responsive web development.\n'
                                  '• Proven ability to collaborate in cross-functional teams and contribute to open-source projects.\n'
                                  '• Motivated and detail-oriented, delivering innovative solutions for complex challenges.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
    );
  }
}

// Custom Painter for Animated Background Circles
class BackgroundCirclePainter extends CustomPainter {
  final double animationValue;

  BackgroundCirclePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 1.5;
    final double centerY = size.height / 2;

    // Floating effect using sine and cosine functions
    final Offset circlePosition = Offset(
      centerX + 50 * sin(animationValue),
      centerY + 30 * cos(animationValue),
    );

    // Draw animated circles
    canvas.drawCircle(circlePosition, 120, paint);
    canvas.drawCircle(Offset(circlePosition.dx + 200, circlePosition.dy + 100), 90, paint);
    canvas.drawCircle(Offset(circlePosition.dx - 200, circlePosition.dy - 100), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Container(
        color: Colors.blue[50], // Light background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "",
              style: TextStyle(fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Row with Skill Diagram on left and description on right
            Expanded(
              child: Row(
                children: [
                  // Skill Diagram on the left
                  const Expanded(
                    flex: 1,
                    child: SkillDiagram(),
                  ),

                  // About me text on the right
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hi, I'm Rishi Bhardwaj! 👋",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "I am a passionate Software Developer with expertise in Flutter, Firebase, and Python. "
                                "I love building mobile applications and exploring new technologies. "
                                "My goal is to create impactful and user-friendly solutions.",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "When I'm not coding, you can find me learning about new tech trends, "
                                "solving coding challenges, or contributing to open-source projects.",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 20),

                          // "Get in Touch" button

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Social media icons at the bottom
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(FontAwesomeIcons.linkedin, "https://www.linkedin.com/in/rishi-bhardwaj-166116249", Colors.blue),
                _buildSocialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/rishi_bhardwaj_52", Colors.pink),
                _buildSocialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/your_profile", Colors.blueAccent),
                _buildSocialIcon(FontAwesomeIcons.github, "https://github.com/panditrishi54", Colors.black),
                _buildSocialIcon(FontAwesomeIcons.envelope, "mailto:panditrishi54@gmail.com?subject=Hello&body=Hi there!", Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to show contact options
  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Get in Touch",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Contact options
              _buildContactTile(FontAwesomeIcons.envelope, "Email Me", "panditrishi54@gmail.com", "mailto:panditrishi54@gmail.com?subject=Hello&body=Hi there!"),
              _buildContactTile(FontAwesomeIcons.whatsapp, "WhatsApp", "+91 8006028218", "https://wa.me/918006028218?text=Hello%20Rishi!"),
              _buildContactTile(FontAwesomeIcons.linkedin, "LinkedIn", "linkedin.com/in/rishi-bhardwaj", "https://www.linkedin.com/in/rishi-bhardwaj-166116249"),
              _buildContactTile(FontAwesomeIcons.instagram, "Instagram", "@rishi_bhardwaj_52", "https://www.instagram.com/rishi_bhardwaj_52"),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Function to build social media icons
  Widget _buildSocialIcon(IconData icon, String url, Color color) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint("Could not open $url");
        }
      },
    );
  }

  // Function to build contact tiles
  Widget _buildContactTile(IconData icon, String title, String subtitle, String url) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint("Could not open $url");
        }
      },
    );
  }
}

class ResumeSection extends StatelessWidget {
  const ResumeSection({Key? key}) : super(key: key);

  final String resumeUrl = "https://drive.google.com/file/d/10vlZDJTj7s5HCygNYWrtfPWgriS3uRGj/view?usp=drive_link"; // Replace with actual resume URL

  Future<void> _openResume() async {
    final Uri url = Uri.parse(resumeUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not open $resumeUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    _openResume(); // Automatically open the PDF when this screen is loaded
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Portfolio Section placeholder.
class PortfolioSection extends StatelessWidget {
  const PortfolioSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      body: const Center(
        child: Text(
          'Portfolio Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
// Define the Project class with a const constructor


class Project {
  final String title;
  final String description;
  final String techStack;
  final String projectUrl;
  final String demoUrl;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.projectUrl,
    required this.demoUrl,
  });
}

class ProjectSection extends StatelessWidget {
  const ProjectSection({Key? key}) : super(key: key);

  final List<Project> projects = const [

    Project(
        title: "Food Donor App",
        description: "A Flutter app connecting food donors with charities to minimize food waste.",
        techStack: "Flutter, Dart, Firebase Authentication, Firestore",
        projectUrl: "https://github.com/panditrishi54/donationapp.git",
        demoUrl: "https://food-donation-ceafc.web.app/"
    ),
    Project(
        title: "Portfolio Website",
        description: "A personal portfolio built using Flutter for showcasing projects and skills.",
        techStack: "Flutter, Dart, UI/UX Design",
        projectUrl: "https://github.com/panditrishi54/portfolio",
        demoUrl: "https://rishipotfolio.netlify.app/"
    ),


    Project(
      title: "Gym Registration Website",
      description: "Developed a responsive gym website that facilitates user registration and login.",
      techStack: "HTML, CSS, Bootstrap, JavaScript, Firebase",
      projectUrl: "https://github.com/panditrishi54/GYM_MANAGEMENT_WEB", // Replace with actual link
      demoUrl: "#",
    ),
    Project(
      title: "Home Automation System",
      description: "Developed a home automation system using ESP32 for smart home control.",
      techStack: "C++, Arduino, IoT",
      projectUrl: "https://github.com/panditrishi54/home-automation",
        demoUrl: "#"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projects',
          style: TextStyle(fontStyle: FontStyle.italic,
            fontSize: 24,
            fontWeight: FontWeight.bold, // Makes the text bold

          ), // Makes the text italic

        ),
        centerTitle: true, // Centers the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];

            return Card(
              color: Colors.blueGrey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tech Stack: ${project.techStack}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (project.demoUrl != null) // Show demo button only if demoUrl exists
                            TextButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(project.demoUrl!);
                                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                  debugPrint("Could not open ${project.demoUrl}");
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue, // Different color to distinguish from View Project
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text("View Demo"),
                            ),
                          const SizedBox(height: 20), // Space between buttons
                          TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(project.projectUrl);
                              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                debugPrint("Could not open ${project.projectUrl}");
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("View Project"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class ContactMeSection extends StatelessWidget {
  const ContactMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 1.0, // Adjust opacity for better visibility
              child: Image.asset(
                'assets/img/ww.jpg', // Ensure this image exists in your assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contact Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Add space for better layout

                // Friendly Message
                const Text(
                  "Give me a shout!",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "I'd love to work with you.",
                  style: TextStyle(fontSize: 25, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // Contact List
                _buildContactTile(
                    FontAwesomeIcons.envelope, "Email Me", "panditrishi54@gmail.com",
                    "mailto:panditrishi54@gmail.com"),
                _buildContactTile(
                    FontAwesomeIcons.whatsapp, "WhatsApp", "+91 8006028218",
                    "https://wa.me/918006028218?text=Hello%20Rishi!"),
                _buildContactTile(
                    FontAwesomeIcons.linkedin, "LinkedIn", "linkedin.com/in/rishi-bhardwaj",
                    "https://www.linkedin.com/in/rishi-bhardwaj-166116249"),
                _buildContactTile(
                    FontAwesomeIcons.instagram, "Instagram", "@rishi_bhardwaj_52",
                    "https://www.instagram.com/rishi_bhardwaj_52"),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Function to Build Contact Tiles
  Widget _buildContactTile(IconData icon, String title, String subtitle, String url) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint("Could not open $url");
        }
      },
    );
  }
}


Widget _buildContactTile(IconData icon, String title, String subtitle, String url,{double fontSize = 28}) {
  return ListTile(
    leading: Icon(icon,size: 40, color: Colors.blueAccent),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    onTap: () async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not open $url");
      }
    },
  );
}

// Interactive SkillDiagram widget using CustomPaint.
class SkillDiagram extends StatefulWidget {
  const SkillDiagram({Key? key}) : super(key: key);

  @override
  _SkillDiagramState createState() => _SkillDiagramState();
}

class _SkillDiagramState extends State<SkillDiagram> {
  int? hoveredIndex;

  // Define skills here so they can be accessed dynamically
  final List<String> skillNames = const [
    "Flutter", "Firebase", "Python", "Java", "C", "HTML5", "Dart", "SQL", "Latex"
  ];
  final List<Color> skillColors = const [
    Colors.blue, Colors.orange, Colors.green, Colors.purple,
    Colors.red, Colors.grey, Colors.cyan, Colors.amber, Colors.teal
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            final int numSkills = skillNames.length; // Now it is accessible
            final double spacingX = screenWidth / (sqrt(numSkills) + 1);
            final double spacingY = screenHeight / (sqrt(numSkills) + 1);

            int? newHoveredIndex;
            for (int i = 0; i < numSkills; i++) {
              final Offset position = Offset(
                (i % sqrt(numSkills).toInt()) * spacingX + spacingX / 2,
                (i ~/ sqrt(numSkills).toInt()) * spacingY + spacingY / 2,
              );

              if ((event.localPosition - position).distance < 80) {
                newHoveredIndex = i;
                break;
              }
            }
            if (newHoveredIndex != hoveredIndex) {
              setState(() {
                hoveredIndex = newHoveredIndex;
              });
            }
          },
          onExit: (event) {
            setState(() {
              hoveredIndex = null;
            });
          },
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: SkillDiagramPainter(
              hoveredIndex: hoveredIndex,
              skillNames: skillNames, // Pass dynamically
              skillColors: skillColors,
            ),
          ),
        );
      },
    );
  }
}

  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Resume')),
  //     body: Center(
  //       child: ElevatedButton.icon(
  //         onPressed: _downloadResume,
  //         icon: const Icon(Icons.download),
  //         label: const Text("Download Resume"),
  //         style: ElevatedButton.styleFrom(
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //           backgroundColor: Colors.blueAccent,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         ),
  //       ),
  //     ),
  //   );
  // }


class SkillDiagramPainter extends CustomPainter {
  final int? hoveredIndex;
  final List<String> skillNames;
  final List<Color> skillColors;

  SkillDiagramPainter({
    required this.hoveredIndex,
    required this.skillNames,
    required this.skillColors,
  });

  static const double baseRadius = 70; // Normal size
  static const double hoveredRadius = 85; // Enlarged size on hover

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final int numSkills = skillNames.length;
    final double spacingX = size.width / (sqrt(numSkills) + 1);
    final double spacingY = size.height / (sqrt(numSkills) + 1);

    for (int i = 0; i < numSkills; i++) {
      final Offset position = Offset(
        (i % sqrt(numSkills).toInt()) * spacingX + spacingX / 2,
        (i ~/ sqrt(numSkills).toInt()) * spacingY + spacingY / 2,
      );

      double currentRadius = baseRadius;
      if (hoveredIndex != null && hoveredIndex == i) {
        currentRadius = hoveredRadius;
      }

      paint.color = skillColors[i].withOpacity(0.7);
      canvas.drawCircle(position, currentRadius, paint);

      // Draw skill text centered inside the circle.
      final textSpan = TextSpan(
        text: skillNames[i],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      final textOffset = position - Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
