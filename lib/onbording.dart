import 'package:flutter/material.dart';
import 'package:quickhire/RegisterPage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: PageView(
        controller: _pageController,
        // Disable swiping
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          buildOnboardingPage(
              title: 'Welcome!',
              description: ' Manage your hostel operations efficiently.',
              image: Image.asset('assets/1.jpg')),
          buildOnboardingPage(
              title: 'Explore Features',
              description: 'Discover the powerful tools available for booking, managing reservations',
              image: Image.asset('assets/2.jpg')),
          buildOnboardingPage(
              title: 'Ready to Go!',
              description: 'You\'re all set to begin managing your hostel effortlessly. Let\'s get started!',
              image: Image.asset('assets/3.jpg'),
              actionButton: ElevatedButton(
                onPressed: () {
                  
                   Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Register()));
                },
                child: const Text('Get Started'),
              )),
        ],
      ),
      bottomNavigationBar: _buildIndicatorDots(),
    );
  }

  Widget buildOnboardingPage({
    required String title,
    required String description,
    required Image image,
    Widget? actionButton,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          const SizedBox(height: 20.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10.0),
          Text(description, 
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16.0,)),
          if (actionButton != null) const SizedBox(height: 20.0),
          if (actionButton != null) actionButton,
        ],
      ),
    );
  }

  Widget _buildIndicatorDots() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: _currentPage == index ? 20.0 : 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? Color.fromARGB(255, 120, 11, 192) : Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
            ),
          );
        }),
      ),
    );
  }
}
