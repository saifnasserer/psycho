import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_form_cubit.dart';

class AuthForm extends StatefulWidget {
  final AuthModeState authState;
  final AuthFormState formState;
  final VoidCallback onContinue;
  final VoidCallback onForgotPassword;
  final Future<void> Function(BuildContext) onSelectDate;

  const AuthForm({
    super.key,
    required this.authState,
    required this.formState,
    required this.onContinue,
    required this.onForgotPassword,
    required this.onSelectDate,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _syncControllersWithCubit();
  }

  @override
  void didUpdateWidget(AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllersWithCubit();
  }

  void _syncControllersWithCubit() {
    final formCubit = context.read<AuthFormCubit>();
    final formData = formCubit.formData;

    // Update controllers with current form data
    if (_nameController.text != formData.name) {
      _nameController.text = formData.name;
    }
    if (_emailController.text != formData.email) {
      _emailController.text = formData.email;
    }
    if (_passwordController.text != formData.password) {
      _passwordController.text = formData.password;
    }
    if (_confirmPasswordController.text != formData.confirmPassword) {
      _confirmPasswordController.text = formData.confirmPassword;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      final formCubit = context.read<AuthFormCubit>();

      // Update form data in cubit
      formCubit.updateEmail(_emailController.text);
      formCubit.updatePassword(_passwordController.text);

      if (widget.authState is SignUpMode) {
        formCubit.updateName(_nameController.text);
        formCubit.updateConfirmPassword(_confirmPasswordController.text);
      }

      widget.onContinue();
    }
  }

  String? _validateConfirmPassword(String? value) {
    if (widget.authState is SignUpMode) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      if (value != _passwordController.text) {
        return AppConstants.passwordsDontMatch;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthFormCubit, AuthFormState>(
      builder: (context, formState) {
        final formCubit = context.read<AuthFormCubit>();
        final formData = formCubit.formData;
        final isSignUp = widget.authState is SignUpMode;
        final isLoading = formState is AuthFormLoading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              if (isSignUp) ...[
                CustomTextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  hint: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    if (value.trim().split(' ').length < 2) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.getSpacing(context, 16)),
              ],
              if (isSignUp) ...[
                GestureDetector(
                  onTap: () => widget.onSelectDate(context),
                  child: Container(
                    height: Responsive.getFontSize(context, 56),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getSpacing(
                        context,
                        AppConstants.baseSpacing,
                      ),
                      vertical: Responsive.getSpacing(context, 16),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(
                        Responsive.getBorderRadius(
                          context,
                          AppConstants.baseBorderRadius,
                        ),
                      ),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey[400],
                          size: Responsive.getFontSize(context, 20),
                        ),
                        SizedBox(width: Responsive.getSpacing(context, 12)),
                        Expanded(
                          child: Text(
                            formData.birthDate != null
                                ? '${formData.birthDate!.day}/${formData.birthDate!.month}/${formData.birthDate!.year}'
                                : 'Date of Birth',
                            style: TextStyle(
                              fontSize: Responsive.getFontSize(
                                context,
                                AppConstants.baseFontSize,
                              ),
                              color: formData.birthDate != null
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 16)),
              ],
              CustomTextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                hint: 'Email address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.emailRequired;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return AppConstants.invalidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: Responsive.getSpacing(context, 16)),
              CustomTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                hint: 'Password',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                    size: Responsive.getFontSize(context, 18),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.passwordRequired;
                  }
                  if (value.length < 6) {
                    return AppConstants.passwordTooShort;
                  }
                  return null;
                },
              ),
              SizedBox(height: Responsive.getSpacing(context, 16)),
              if (isSignUp) ...[
                CustomTextField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  hint: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey[400],
                      size: Responsive.getFontSize(context, 18),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: _validateConfirmPassword,
                ),
                SizedBox(height: Responsive.getSpacing(context, 16)),
              ],
              if (!isSignUp)
                TextButton(
                  onPressed: widget.onForgotPassword,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 14),
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              SizedBox(height: Responsive.getSpacing(context, 24)),
              CustomButton(
                text: 'Continue',
                type: ButtonType.primary,
                isFullWidth: true,
                isLoading: isLoading,
                onPressed: _handleContinue,
              ),
            ],
          ),
        );
      },
    );
  }
}
