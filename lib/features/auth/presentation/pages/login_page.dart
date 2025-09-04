import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_form_cubit.dart';
import '../widgets/auth_form.dart';
import '../pages/sign_up.dart';
import '../../../specialist/presentation/pages/specialist_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _screenAnimationController;
  late Animation<double> _screenFadeAnimation;
  late Animation<Offset> _screenSlideAnimation;
  late Animation<double> _contentScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _screenAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _screenFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _screenAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _screenSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _screenAnimationController,
            curve: Curves.easeOutQuart,
          ),
        );

    _contentScaleAnimation = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(
        parent: _screenAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _screenAnimationController.forward();
  }

  @override
  void dispose() {
    _screenAnimationController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final authCubit = context.read<AuthCubit>();
    final formCubit = context.read<AuthFormCubit>();

    formCubit.submitForm();

    if (authCubit.state is SignUpMode) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUpPage(
            email: formCubit.formData.email,
            password: formCubit.formData.password,
          ),
        ),
      );
    } else {
      // Sign In mode - navigate to specialist home page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SpecialistHomePage()),
        (route) => false,
      );
    }
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password page
  }

  void _toggleMode() {
    final authCubit = context.read<AuthCubit>();

    _screenAnimationController.reverse().then((_) {
      authCubit.toggleMode();
      _screenAnimationController.forward();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      lastDate: DateTime.now().subtract(const Duration(days: 6570)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(AppConstants.mintGreen),
              onPrimary: Colors.white,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFF1A1A1A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      context.read<AuthFormCubit>().updateBirthDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthModeState>(
      builder: (context, authState) {
        return BlocBuilder<AuthFormCubit, AuthFormState>(
          builder: (context, formState) {
            return Scaffold(
              backgroundColor: const Color(0xff121212),
              body: Padding(
                padding: Responsive.getDynamicPadding(context),
                child: Center(
                  child: SingleChildScrollView(
                    padding: Responsive.getDynamicPadding(context),
                    child: FadeTransition(
                      opacity: _screenFadeAnimation,
                      child: SlideTransition(
                        position: _screenSlideAnimation,
                        child: ScaleTransition(
                          scale: _contentScaleAnimation,
                          child: Column(
                            children: [
                              _buildHeader(authState),
                              SizedBox(
                                height: Responsive.getSpacing(context, 32),
                              ),
                              _buildModeToggle(authState),
                              SizedBox(
                                height: Responsive.getSpacing(context, 24),
                              ),
                              AuthForm(
                                authState: authState,
                                formState: formState,
                                onContinue: _handleContinue,
                                onForgotPassword: _handleForgotPassword,
                                onSelectDate: _selectDate,
                              ),
                              SizedBox(
                                height: Responsive.getSpacing(context, 24),
                              ),
                              _buildAlternativeLogin(),
                              SizedBox(
                                height: Responsive.getSpacing(context, 24),
                              ),
                              _buildLegalText(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(AuthModeState authState) {
    return Column(
      children: [
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 32),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        Text(
          authState is SignInMode
              ? 'Sign in to your account'
              : 'Create your account',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            color: Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildModeToggle(AuthModeState authState) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (authState is! SignInMode) _toggleMode();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.getSpacing(context, 12),
                ),
                decoration: BoxDecoration(
                  color: authState is SignInMode
                      ? const Color(AppConstants.mintGreen)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 20),
                  ),
                ),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (authState is! SignUpMode) _toggleMode();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.getSpacing(context, 12),
                ),
                decoration: BoxDecoration(
                  color: authState is SignUpMode
                      ? const Color(AppConstants.mintGreen)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 20),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[600])),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getSpacing(context, 16),
              ),
              child: Text(
                'or continue with',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  color: Colors.grey[400],
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[600])),
          ],
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Responsive.getFontSize(context, 60),
              width: Responsive.getFontSize(context, 60),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 20),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Implement Google sign in
                },
                icon: const Icon(
                  Icons.g_mobiledata,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: Responsive.getSpacing(context, 16)),
            Container(
              width: Responsive.getFontSize(context, 60),
              height: Responsive.getFontSize(context, 60),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 20),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Implement Apple sign in
                },
                icon: const Icon(Icons.apple, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegalText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: Responsive.getFontSize(context, 12),
          color: Colors.grey[400],
        ),
        children: [
          const TextSpan(text: 'By continuing, you agree to our '),
          TextSpan(
            text: 'Terms of Service',
            style: const TextStyle(
              color: Color(AppConstants.mintGreen),
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              color: Color(AppConstants.mintGreen),
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
