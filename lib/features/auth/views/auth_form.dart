import 'package:flutter/material.dart';
import 'package:glib_practicas/app_colors.dart';
import 'package:glib_practicas/widgets/styles.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, this.resetFn, {super.key});

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String phoneArea,
    String phone,
    String type,
    String estado,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  final void Function(String emailpassword, BuildContext ctx) resetFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userPhoneArea = '';
  var _userPhone = '';
  final _userType = '';
  final _userEstado = 'pendiente';
  bool _obscureText = true;
  String _emailpassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userPhoneArea.trim(),
        _userPhone.trim(),
        _userType,
        _userEstado,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: AppColors.primary,
                    height: 160,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              _emailTxt(),
                              _clabeTxt(),
                              if (!_isLogin) _nombreTxt(),
                              if (!_isLogin) _phoneTxt(context),
                              if (!_isLogin) _phoneAlert(),
                              const SizedBox(height: 20),
                              if (widget.isLoading)
                                const CircularProgressIndicator(),
                              if (!widget.isLoading) _loginButton(context),
                              const SizedBox(height: 10),
                              if (!widget.isLoading)
                                if (_isLogin) _olvideClaveBotton(context),
                              if (!widget.isLoading) _redirectButton(context),
                              // if (esMobile) _informacion(context),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _redirectButton(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Material(
        borderRadius: BorderRadius.circular(40.0),
        color: Theme.of(context).primaryColorDark,
        child: TextButton(
          onPressed: () {
            setState(() {
              _isLogin = !_isLogin;
            });
          },
          child: Center(
            child: Text(
              _isLogin ? "Crear una cuenta" : "Ya tengo una cuenta",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.black,
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        child: TextButton(
          onPressed: _trySubmit,
          child: Center(
            child: Text(
              _isLogin ? "Iniciar sesión" : "Crear cuenta",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneAlert() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        '* ingrese area sin 0 y telefono sin 15',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.red.shade200,
        ),
      ),
    );
  }

  Widget _phoneTxt(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            child: TextFormField(
              key: const ValueKey('phone'),
              decoration: InputDecoration(
                labelText: 'AREA',
                labelStyle: styleTB(),
                focusedBorder: underLine(),
              ),
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por ingrese area';
                }
                return null;
              },
              onSaved: (value) {
                _userPhoneArea = value!;
              },
              // ignore: missing_return
            ),
          ),
          Expanded(
            child: TextFormField(
              key: const ValueKey('phone'),
              decoration: InputDecoration(
                labelText: 'TELEFONO',
                labelStyle: styleTB(),
                focusedBorder: underLine(),
              ),
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por ingrese su nombre completo';
                }
                return null;
              },
              onSaved: (value) {
                _userPhone = value!;
              },
              // ignore: missing_return
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _nombreTxt() {
    return TextFormField(
      key: const ValueKey('username'),
      decoration: InputDecoration(
        labelText: 'NOMBRE COMPLETO',
        labelStyle: styleTB(),
        focusedBorder: underLine(),
      ),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      enableSuggestions: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por ingrese su nombre completo';
        }
        return null;
      },
      onSaved: (value) {
        _userName = value!;
      },
      // ignore: missing_return
    );
  }

  TextFormField _clabeTxt() {
    return TextFormField(
      key: const ValueKey('password'),
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'CONTRASEÑA',
        labelStyle: styleTB(),
        focusedBorder: underLine(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),

      // ignore: missing_return
      validator: (value) {
        if (value!.isEmpty || value.length < 4) {
          return 'Por favor ingrese su contraseña';
        }
        return null;
      },
      onSaved: (value) {
        _userPassword = value!;
      },
    );
  }

  TextFormField _emailTxt() {
    return TextFormField(
      key: const ValueKey('email'),
      decoration: InputDecoration(
        labelText: 'CORREO ELECTRÓNICO',
        labelStyle: styleTB(),
        focusedBorder: underLine(),
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese un correo valido o usuario.';
        }
        return null;
      },
      onSaved: (value) {
        _userEmail = value!;
      },
    );
  }

  TextButton _olvideClaveBotton(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                title: const Text("Cambiar contraseña"),
                content: Form(
                  key: formKey1,
                  child: TextFormField(
                    onSaved: (val) => _emailpassword = val!,
                    validator: (val) =>
                        !val!.contains('@') ? "Correo invalido" : null,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Ingresa tu correo",
                      labelText: "Correo electrónico",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    autofocus: true,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "CANCELAR",
                        style: TextStyle(color: Colors.black54),
                      )),
                  TextButton(
                    onPressed: () {
                      _passwordReset();
                    },
                    child: Text(
                      "ENVIAR",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              );
            });
      },
      child: Text(
        "¿Olvidaste tu contraseña?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _passwordReset() async {
    final form = formKey1.currentState;
    if (form!.validate()) {
      form.save();
      widget.resetFn(_emailpassword, context);
    }
  }
}
