import 'package:cooks_social/bloc/login/login_bloc.dart';
import 'package:cooks_social/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(),
      child: Holder(),
    ));
  }
}

class Holder extends StatefulWidget {
  @override
  _HolderState createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return SafeArea(
      child: BlocListener(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginFailedState) {
            final snackBar = SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Color(0xFFFC6C6C),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (state is LoginSuccessfulState) {
            final snackBar = SnackBar(
              content: Text(
                "Login Successful",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green,
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (context, state) {
            return buildLoginScreen(_loginBloc, state);
          },
        ),
      ),
    );
  }

  Widget setUpButtonChild(LoginState loginState) {
    if (loginState is LoginLoadingState) {
      return Container(
        child: LinearProgressIndicator(backgroundColor: Colors.white),
      );
    } else if (loginState is LoginSuccessfulState) {
      return Icon(Icons.check, color: Colors.white);
    } else {
      return Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      );
    }
  }

  Widget buildLoginScreen(LoginBloc loginBloc, LoginState loginState) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFC6C6C),
                ),
                child: Image.asset(
                  "assets/images/bg.png",
                  fit: BoxFit.none,
                  color: Color(0xFFDB162F),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              controller: _emailController,
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "chef123@gmail.com",
                                labelText: "Email Address",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 56,
                      ),
                      child: MaterialButton(
                        padding: EdgeInsets.all(18),
                        child: setUpButtonChild(loginState),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            loginBloc.add(
                              LoginInitiatedEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            transform: Matrix4.translationValues(0, -20, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid email';
    else
      return null;
  }
}
