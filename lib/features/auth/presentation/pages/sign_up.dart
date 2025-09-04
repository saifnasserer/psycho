import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../specialist/presentation/pages/specialist_home_page.dart';

class SignUpPage extends StatefulWidget {
  final String email;
  final String password;

  const SignUpPage({super.key, required this.email, required this.password});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late AnimationController _cardsAnimationController;
  late AnimationController _buttonAnimationController;
  late AnimationController _specializationAnimationController;

  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _cardsFadeAnimation;
  late Animation<double> _cardsScaleAnimation;
  late Animation<double> _buttonFadeAnimation;
  late Animation<double> _specializationFadeAnimation;
  late Animation<Offset> _specializationSlideAnimation;

  String? _selectedRole;
  String? _selectedSpecialization;
  bool _isLoading = false;

  // Specialization options
  final List<Map<String, dynamic>> _specializations = [
    {
      'id': 'psychotherapist',
      'title': 'Psychotherapist',
      'subtitle': 'Talk therapy and counseling specialist',
      'icon': Icons.chat_bubble_outline,
    },
    {
      'id': 'psychologist',
      'title': 'Psychologist',
      'subtitle': 'Clinical psychology and assessment',
      'icon': Icons.psychology_outlined,
    },
    {
      'id': 'psychiatrist',
      'title': 'Psychiatrist',
      'subtitle': 'Medical treatment and medication',
      'icon': Icons.medical_services_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();

    // Title animation controller
    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Cards animation controller
    _cardsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Button animation controller
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Specialization animation controller
    _specializationAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Title animations
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleAnimationController, curve: Curves.easeOut),
    );

    _titleSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _titleAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Cards animations
    _cardsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardsAnimationController, curve: Curves.easeOut),
    );

    _cardsScaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Button animation
    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Specialization animations
    _specializationFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _specializationAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _specializationSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _specializationAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Start staggered animations
    _startAnimations();
  }

  void _startAnimations() async {
    // Start title animation
    _titleAnimationController.forward();

    // Wait a bit, then start cards animation
    await Future.delayed(const Duration(milliseconds: 300));
    _cardsAnimationController.forward();

    // Wait a bit more, then start button animation
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonAnimationController.forward();
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    _cardsAnimationController.dispose();
    _buttonAnimationController.dispose();
    _specializationAnimationController.dispose();
    super.dispose();
  }

  void _selectRole(String role) {
    setState(() {
      _selectedRole = role;
      _selectedSpecialization = null; // Reset specialization when role changes
    });

    // Animate specialization cards if specialist is selected
    if (role == AppConstants.roleTherapist) {
      _specializationAnimationController.forward();
    } else {
      _specializationAnimationController.reverse();
    }
  }

  void _selectSpecialization(String specialization) {
    setState(() {
      _selectedSpecialization = specialization;
    });
  }

  void _handleContinue() {
    if (_selectedRole != null) {
      // For specialist, require specialization selection
      if (_selectedRole == AppConstants.roleTherapist &&
          _selectedSpecialization == null) {
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // TODO: Implement signup logic with selected role and specialization
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // Navigate to specialist home page
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SpecialistHomePage()),
            (route) => false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Responsive.getDynamicPadding(context),
          child: Column(
            children: [
              SizedBox(height: Responsive.getSpacing(context, 40)),

              // Title with fade and slide animation
              FadeTransition(
                opacity: _titleFadeAnimation,
                child: SlideTransition(
                  position: _titleSlideAnimation,
                  child: _buildTitle(),
                ),
              ),

              SizedBox(height: Responsive.getSpacing(context, 60)),

              // Role selection cards with fade and scale animation
              FadeTransition(
                opacity: _cardsFadeAnimation,
                child: ScaleTransition(
                  scale: _cardsScaleAnimation,
                  child: _buildRoleCards(),
                ),
              ),

              // Specialization cards (only shown for specialists)
              if (_selectedRole == AppConstants.roleTherapist) ...[
                SizedBox(height: Responsive.getSpacing(context, 32)),
                FadeTransition(
                  opacity: _specializationFadeAnimation,
                  child: SlideTransition(
                    position: _specializationSlideAnimation,
                    child: _buildSpecializationCards(),
                  ),
                ),
              ],

              SizedBox(height: Responsive.getSpacing(context, 40)),

              // Continue button with fade animation
              FadeTransition(
                opacity: _buttonFadeAnimation,
                child: _buildContinueButton(),
              ),

              SizedBox(height: Responsive.getSpacing(context, 20)),

              // Back button with fade animation
              FadeTransition(
                opacity: _buttonFadeAnimation,
                child: _buildBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'I am',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 32),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        Text(
          'Choose your role to get started',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            color: Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRoleCards() {
    return Column(
      children: [
        // Client Card
        _buildRoleCard(
          title: 'a person who is looking for a specialist',
          subtitle: 'I need mental health support and guidance',
          icon: Icons.person_outline,
          role: AppConstants.roleClient,
          isSelected: _selectedRole == AppConstants.roleClient,
        ),

        SizedBox(height: Responsive.getSpacing(context, 20)),

        // Specialist Card
        _buildRoleCard(
          title: 'a specialist',
          subtitle: 'I provide mental health services and support',
          icon: Icons.psychology_outlined,
          role: AppConstants.roleTherapist,
          isSelected: _selectedRole == AppConstants.roleTherapist,
        ),
      ],
    );
  }

  Widget _buildSpecializationCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Specialization title
        Padding(
          padding: EdgeInsets.only(
            left: Responsive.getSpacing(context, 4),
            bottom: Responsive.getSpacing(context, 16),
          ),
          child: Text(
            'Choose your specialization:',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        // Specialization cards
        ...List.generate(_specializations.length, (index) {
          final specialization = _specializations[index];
          final isLast = index == _specializations.length - 1;

          return Column(
            children: [
              _buildSpecializationCard(
                title: specialization['title'],
                subtitle: specialization['subtitle'],
                icon: specialization['icon'],
                specializationId: specialization['id'],
                isSelected: _selectedSpecialization == specialization['id'],
              ),
              if (!isLast) SizedBox(height: Responsive.getSpacing(context, 12)),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String role,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _selectRole(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: Responsive.getDynamicPadding(context, basePadding: 24),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A2A) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 20),
          ),
          border: Border.all(
            color: isSelected
                ? const Color(AppConstants.mintGreen)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(AppConstants.mintGreen).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: Responsive.getFontSize(context, 60),
              height: Responsive.getFontSize(context, 60),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(AppConstants.mintGreen)
                    : const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 16),
                ),
              ),
              child: Icon(
                icon,
                size: Responsive.getFontSize(context, 28),
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),

            SizedBox(width: Responsive.getSpacing(context, 20)),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 18),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 14),
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: Responsive.getFontSize(context, 24),
              height: Responsive.getFontSize(context, 24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(AppConstants.mintGreen)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(AppConstants.mintGreen)
                      : Colors.grey[600]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: Responsive.getFontSize(context, 16),
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecializationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String specializationId,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _selectSpecialization(specializationId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: Responsive.getDynamicPadding(context, basePadding: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A2A) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 16),
          ),
          border: Border.all(
            color: isSelected
                ? const Color(AppConstants.mintGreen)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(AppConstants.mintGreen).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: Responsive.getFontSize(context, 48),
              height: Responsive.getFontSize(context, 48),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(AppConstants.mintGreen)
                    : const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 12),
                ),
              ),
              child: Icon(
                icon,
                size: Responsive.getFontSize(context, 24),
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),

            SizedBox(width: Responsive.getSpacing(context, 16)),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 2)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 12),
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: Responsive.getFontSize(context, 20),
              height: Responsive.getFontSize(context, 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(AppConstants.mintGreen)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(AppConstants.mintGreen)
                      : Colors.grey[600]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: Responsive.getFontSize(context, 14),
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    bool canContinue = _selectedRole != null;
    if (_selectedRole == AppConstants.roleTherapist) {
      canContinue = _selectedSpecialization != null;
    }

    return CustomButton(
      text: 'Continue',
      type: ButtonType.primary,
      isFullWidth: true,
      isLoading: _isLoading,
      onPressed: canContinue ? _handleContinue : null,
    );
  }

  Widget _buildBackButton() {
    return CustomButton(
      text: 'Back to Login',
      type: ButtonType.text,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
