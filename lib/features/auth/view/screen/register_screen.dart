import 'package:api_cubit_task/features/auth/cubit/auth_cubit.dart';
import 'package:api_cubit_task/features/auth/cubit/auth_state.dart';
import 'package:api_cubit_task/features/home/view/widget/main_navigation_screen.dart';
import 'package:api_cubit_task/features/shared/widgets/custom_button.dart';
import 'package:api_cubit_task/features/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,

        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurple.shade600, Colors.grey.shade50],
                  stops: const [0.0, 0.6],
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create a new account to continue',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      controller: nameController,
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: emailController,
                      hintText: 'example@email.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: phoneController,
                      hintText: '01xxxxxxxxx',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length != 11) {
                          return 'Phone number must be 11 digits';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Phone number must contain only digits';
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: nationalIdController,
                      hintText: 'Enter your national ID',
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your national ID';
                        }
                        String cleanValue = value.replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        );
                        if (cleanValue.length != 14) {
                          return 'National ID must be exactly 14 digits';
                        }
                        if (!RegExp(r'^[0-9]{14}$').hasMatch(cleanValue)) {
                          return 'National ID must contain only digits';
                        }
                        if (!cleanValue.startsWith('2') &&
                            !cleanValue.startsWith('3')) {
                          return 'Invalid National ID format';
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: genderController,
                      hintText: 'Select: male or female',
                      prefixIcon: Icons.wc_outlined,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        final lowercaseValue = value.toLowerCase().trim();
                        if (lowercaseValue != 'male' &&
                            lowercaseValue != 'female') {
                          return 'Please enter either "male" or "female"';
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter a strong password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return 'Password must contain at least one lowercase letter';
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one number';
                        }
                        if (!RegExp(
                          r'[!@#$%^&*(),.?":{}|<>]',
                        ).hasMatch(value)) {
                          return 'Password must contain at least one special character';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoaded) {
                          if (state.data.status == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                backgroundColor: Colors.green.withAlpha(200),
                                content: Center(
                                  child: Text(state.data.message),
                                ),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainNavigationScreen(),
                              ),
                            );
                          } else if (state.data.status == 'error') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                backgroundColor: Colors.red.withAlpha(200),
                                content: Center(
                                  child: Text(state.data.message),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: CustomButton(
                        text: 'Create Account',
                        icon: Icons.person_add,
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          final cubit = context.read<AuthCubit>();
                          cubit.registerCubit(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            nationalId: nationalIdController.text,
                            gender: genderController.text,
                            password: passwordController.text,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: Colors.deepPurple.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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
