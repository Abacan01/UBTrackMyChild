import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isGoogleLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ]
  );

  void _handleGoogleSignIn() async {
  if (!mounted) return;
  
  setState(() {
    _isGoogleLoading = true;
  });

  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    if (googleUser != null) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in as ${googleUser.displayName}'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    }
  } catch (error) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Google Sign-In failed: $error'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (!mounted) return;
    
    setState(() {
      _isGoogleLoading = false;
    });
  }
}

  void _handleLogin() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    
    setState(() {
      _isLoading = false;
    });

  Navigator.pushReplacement(
    context,
   MaterialPageRoute(builder: (context) => const MainNavigation()),
);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/New UBsafestep.png',
                    width: 400,
                    height: 300,
                ),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8), 
              Text(
                'Login to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF862334),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
                Row(
                 children: [
                     Expanded(
                      child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
               ),
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                  style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
        ),
      ),
    ),
    Expanded(
      child: Divider(
        color: Colors.grey[400],
        thickness: 1,
      ),
    ),
  ],
),
const SizedBox(height: 16),

// Google Sign-In Button
SizedBox(
  width: double.infinity,
  height: 50,
  child: OutlinedButton(
    onPressed: _isGoogleLoading ? null : _handleGoogleSignIn,
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white,
      side: BorderSide(color: Color(0xFF862334)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
    ),
    child: _isGoogleLoading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/GoogleLogo.png', // Add this image to your assets
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.account_circle, color: Colors.blue),
              ),
              const SizedBox(width: 9),
              const Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
  ),
),
                const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                  'Forgot Password?',
                    style: TextStyle(
                   color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}