import '../components/cool-card.dart'

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CoolCard(
              imagePath: 'assets/images/logo.svg',
              // bottomText: 'Sign in with Google',
              // bottomSubtext: 'Sign in with your Google account',
            ),
          ],
        ),
      ),
    );
  }
}
