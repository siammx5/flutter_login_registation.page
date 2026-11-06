import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../main.dart'
    show appPrimary, appTextMain, appTextSecondary, appIconCircleBg;
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController     = TextEditingController();
  final emailController    = TextEditingController();
  final phoneController    = TextEditingController();
  final passwordController = TextEditingController();

  final nameRegex = RegExp(r'^[a-zA-Z ]{3,}$');
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final phoneRegex = RegExp(r'^(?:\+8801|01)[3-9]\d{8}$');
  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
  );

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      // ── resizeToAvoidBottomInset: false keeps the card fixed when
      // the keyboard opens; the layout does not reflow or scroll. ────────
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shadowColor: const Color(0x18000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: const BorderSide(color: Color(0xFFE8E8E8), width: 1),
                ),
                child: Padding(
                  // Tightened vertical padding so everything fits without
                  // needing a scroll at typical phone screen heights.
                  padding: const EdgeInsets.fromLTRB(26, 24, 26, 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── User-add icon circle ─────────────────────────
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: appIconCircleBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 34,
                            color: appPrimary,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // ── Heading ──────────────────────────────────────
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: appTextMain,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Register to get started',
                          style: TextStyle(
                            fontSize: 13,
                            color: appTextSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Full Name field ──────────────────────────────
                        InputField(
                          controller: nameController,
                          label: 'Full Name',
                          prefixIcon: Icons.person_outline_rounded,
                          validator: (value) {
                            if (value == null ||
                                !nameRegex.hasMatch(value.trim())) {
                              return 'Enter a valid name (at least 3 letters)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 11),

                        // ── Email field ──────────────────────────────────
                        InputField(
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                !emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 11),

                        // ── Phone Number field ───────────────────────────
                        InputField(
                          controller: phoneController,
                          label: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null ||
                                !phoneRegex.hasMatch(value.trim())) {
                              return 'Enter a valid BD phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 11),

                        // ── Password field ───────────────────────────────
                        InputField(
                          controller: passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                !passwordRegex.hasMatch(value)) {
                              return '8+ chars, uppercase, lowercase, number & symbol';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 22),

                        // ── Register button ──────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Registration validation successful!',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('Register'),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // ── Login link ───────────────────────────────────
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: appTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: appPrimary,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
