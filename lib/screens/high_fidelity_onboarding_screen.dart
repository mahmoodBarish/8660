import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Required for go_router navigation

class HighFidelityOnboardingScreen extends StatefulWidget {
  const HighFidelityOnboardingScreen({super.key});

  @override
  State<HighFidelityOnboardingScreen> createState() => _HighFidelityOnboardingScreenState();
}

class _HighFidelityOnboardingScreenState extends State<HighFidelityOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    // Figma reference values for responsive scaling
    const double figmaHeight = 812;
    const double figmaWidth = 375;

    // Image responsiveness
    const double imageHeightFigma = 536; // Height of the background image
    final double imageHeight = screenHeight * (imageHeightFigma / figmaHeight);

    // Bottom content container (gradient, text, button) responsiveness
    const double gradientContainerYFigma = 452; // Y-start of the gradient container
    final double gradientContainerResponsiveHeight = screenHeight - (gradientContainerYFigma / figmaHeight * screenHeight);

    // Text & Button layout responsiveness
    const double contentHorizontalPaddingFigma = 24; // Padding for the main column content (text and button)
    const double text1YFigma = 476; // Y-start of "Fall in Love..." text
    const double textSpacingFigma = 8; // Spacing between title and subtitle (from text group `itemSpacing`)

    const double buttonHeightFigma = 56;
    const double buttonYFigma = 702; // Y-start of "Get Started" button

    // Home Indicator responsiveness
    const double homeIndicatorYFigma = 799; // Y-start of home indicator
    const double homeIndicatorHeightFigma = 5;
    const double homeIndicatorWidthFigma = 134;
    const double homeIndicatorBottomOffsetFigma = 8; // Space from physical bottom edge to indicator bottom (812 - 799 - 5)

    final double responsiveContentHorizontalPadding = contentHorizontalPaddingFigma / figmaWidth * screenWidth;

    // Space between button's bottom edge and home indicator's top edge
    // Calculated as: (Home Indicator Y-start) - (Button Y-start + Button Height)
    const double spaceBetweenButtonAndHomeIndicatorFigma = homeIndicatorYFigma - (buttonYFigma + buttonHeightFigma); // 799 - (702 + 56) = 41px

    return Scaffold(
      backgroundColor: Colors.black, // Overall screen background color
      body: Stack(
        children: [
          // 1. Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Image.asset(
              'assets/images/I179_50_417_719.png', // Correct asset path
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay and Content (Text & Button)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: gradientContainerResponsiveHeight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF050505).withOpacity(0), // Figma color (r: 0.0196, g: 0.0196, b: 0.0196, a: 0)
                    const Color(0xFF050505), // Figma color (r: 0.0196, g: 0.0196, b: 0.0196, a: 1)
                  ],
                  stops: const [0.0, 0.2367], // Gradient stops from Figma (0 and 0.2367)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: responsiveContentHorizontalPadding,
                  right: responsiveContentHorizontalPadding,
                  bottom: safeAreaBottom, // Account for system bottom inset
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Space from top of gradient container to the main title text
                    SizedBox(height: (text1YFigma - gradientContainerYFigma) / figmaHeight * screenHeight),
                    Text(
                      'Fall in Love with Coffee in Blissful Delight!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600, // Sora-SemiBold
                        height: 1.5, // Calculated from lineHeightPx: 48, fontSize: 32
                        letterSpacing: 0.16,
                      ),
                    ),
                    SizedBox(height: textSpacingFigma / figmaHeight * screenHeight), // Spacing between title and subtitle
                    Text(
                      'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        color: const Color(0xFFA2A2A2), // Figma color (r: 0.635, g: 0.635, b: 0.635, a: 1)
                        fontSize: 14,
                        fontWeight: FontWeight.w400, // Sora-Regular
                        height: 1.5, // Calculated from lineHeightPx: 21, fontSize: 14
                        letterSpacing: 0.14,
                      ),
                    ),
                    const Spacer(), // Pushes the button towards the bottom

                    // Get Started Button
                    SizedBox(
                      width: double.infinity, // Button fills available horizontal space defined by parent padding
                      height: buttonHeightFigma / figmaHeight * screenHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the home screen using go_router
                          context.go('/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC67C4E), // Figma color (r: 0.776, g: 0.486, b: 0.305, a: 1)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // Figma cornerRadius: 16
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16, // Figma's button padding (paddingTop: 16, paddingBottom: 16)
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // Sora-SemiBold
                          ),
                        ),
                      ),
                    ),
                    // Space between button's bottom and home indicator's top
                    SizedBox(height: spaceBetweenButtonAndHomeIndicatorFigma / figmaHeight * screenHeight),
                  ],
                ),
              ),
            ),
          ),

          // 3. Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false, // Prevents bottom safe area inset for the status bar
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveContentHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '9:41', // Figma text content
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 15, // Adjusted font size for readability
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_alt, color: Colors.white.withOpacity(0.4), size: 18), // Interpreted from Figma vector
                        const SizedBox(width: 4),
                        Icon(Icons.wifi, color: Colors.white.withOpacity(0.4), size: 18), // Interpreted from Figma vector
                        const SizedBox(width: 4),
                        Icon(Icons.battery_full, color: Colors.white.withOpacity(0.4), size: 18), // Interpreted from Figma vector
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Home Indicator
          Positioned(
            bottom: safeAreaBottom + (homeIndicatorBottomOffsetFigma / figmaHeight * screenHeight),
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: homeIndicatorWidthFigma / figmaWidth * screenWidth,
                height: homeIndicatorHeightFigma / figmaHeight * screenHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFF242424), // Figma color (r: 0.141, g: 0.141, b: 0.141, a: 1)
                  borderRadius: BorderRadius.circular(100), // Figma cornerRadius: 100
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}