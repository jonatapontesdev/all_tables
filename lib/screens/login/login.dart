import 'package:flutter/material.dart';
import 'package:all_table/_core/colors.dart';
import 'package:all_table/_core/decorations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool loginNow = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Processa o login
      if (loginNow) {
        print("entrei ok");
      } else {
        print("entrei ok");
        print("${_emailController.text}, ${_passwordController.text}");
      }
    }
  }

  void _navigateToSignup() {
    setState(() {
      loginNow = !loginNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MineColors.azulEscuro,
      body: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 27.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildForm(),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_mobile.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 150.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color.fromARGB(1, 0, 0, 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/logo_jp.png", height: 31),
        Row(
          children: [
            Text(
              loginNow ? "NÃO TEM CONTA? " : "JÁ TEM CONTA? ",
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: MineColors.cinza1,
              ),
            ),
            GestureDetector(
              onTap: _navigateToSignup,
              child: Text(
                loginNow ? "CADASTRE-SE" : "LOGAR-SE",
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: Column(
          key: ValueKey<bool>(loginNow),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loginNow ? "LOGIN" : "CADASTRO",
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 62.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 13.0),
            const Text(
              "Entre com seu E-mail e Senha",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 19.0),
            _buildEmailField(),
            const SizedBox(height: 8.0),
            _buildPasswordField(),
            Visibility(
              visible: !loginNow,
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  _buildConfirmPasswordField(),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            _buildLoginButton(),
            const Divider(
              color: MineColors.cinza2,
              height: 60.0,
            ),
            const Text(
              "Ou continue com",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: MineColors.cinza1,
              ),
            ),
            const SizedBox(height: 15.0),
            _buildSocialButtons(),
            const SizedBox(height: 20.0),
            _buildTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: getAuthenticationBoxDecoration(),
      child: TextFormField(
        controller: _emailController,
        style: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          color: MineColors.cinza3,
        ),
        decoration:
            getAuthenticationInputDecoration("E-mail", Icons.mail_outline),
        validator: (value) {
          if (value == null || value.isEmpty || !value.contains("@")) {
            return 'Por favor, insira um e-mail válido';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: getAuthenticationBoxDecoration(),
      child: TextFormField(
        controller: _passwordController,
        style: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          color: MineColors.cinza3,
        ),
        obscureText: true,
        decoration:
            getAuthenticationInputDecoration("Senha", Icons.lock_outline),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira uma senha';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: getAuthenticationBoxDecoration(),
      child: TextFormField(
        controller: _confirmPasswordController,
        style: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Poppins',
          color: MineColors.cinza3,
        ),
        obscureText: true,
        decoration:
            getAuthenticationInputDecoration("Confirmar Senha", Icons.lock),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, confirme sua senha';
          }
          if (value != _passwordController.text) {
            return 'As senhas não correspondem';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _login,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              MineColors.azul3,
              MineColors.roxo4,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Text(
            loginNow ? "Entrar" : "Cadastrar",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.92,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: getAuthenticationBoxDecoration(),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.email, color: Colors.white),
              label: const Text(
                'Google',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MineColors.azulClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Container(
            decoration: getAuthenticationBoxDecoration(),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook, color: Colors.white),
              label: const Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MineColors.azulClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Row(
      children: [
        Text(
          loginNow
              ? "Ao logar, você concorda com nossos "
              : "Ao registrar, você concorda com nossos ",
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 10.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: MineColors.cinza1,
          ),
        ),
        const Text(
          "Termos e Condições",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: MineColors.roxo1,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text(
          "COPYRIGHT BY JP DIGITAL SOLUTIONS",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: MineColors.azul1,
          ),
        ),
      ],
    );
  }
}
