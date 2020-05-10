import 'dart:io';

import 'package:cooks_social/bloc/signup/signup_bloc.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: Content(),
      ),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  File _image;
  String _filename;

  Future<void> getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    print(await image.length());
    setState(() {
      _image = image;
      _filename = _image.path.split("/").last;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SignupBloc _signupBloc = BlocProvider.of<SignupBloc>(context);

    return SafeArea(
      child: BlocListener(
        bloc: _signupBloc,
        listener: (context, state) {
          if (state is SignupFailedState) {
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
          } else if (state is SignupSuccessfulState) {
            final snackBar = SnackBar(
              content: Text(
                "Signup Successful",
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
        child: BlocBuilder<SignupBloc, SignupState>(
          bloc: _signupBloc,
          builder: (context, state) {
            return buildLoginScreen(_signupBloc, state);
          },
        ),
      ),
    );
  }

  Widget setUpButtonChild(SignupState signupState) {
    if (signupState is SignupLoadingState) {
      return Container(
        child: LinearProgressIndicator(backgroundColor: Colors.white),
      );
    } else if (signupState is SignupSuccessfulState) {
      return Icon(Icons.check, color: Colors.white);
    } else {
      return Text(
        "SIGN UP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      );
    }
  }

  Widget buildLoginScreen(SignupBloc signupBloc, SignupState signupState) {
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
                child: SvgPicture.asset(
                  "assets/images/bg.svg",
                  fit: BoxFit.none,
                  color: Color(0xFFDB162F),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "Sign up",
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
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _image == null
                                          ? AssetImage(
                                              "assets/images/avatar.png")
                                          : FileImage(_image),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  getImageFromGallery();
                                },
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Add a profile picture",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Name is required";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Artie Bucco",
                                  labelText: "Name",
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                controller: _usernameController,
                                validator: (value) {
                                  if (value.length < 5) {
                                    return "Username must be at least 5 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "thebestcook",
                                  labelText: "Username",
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                controller: _emailController,
                                validator: validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "artiebucco@gmail.com",
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
                                validator: (value) {
                                  if (value.length < 6) {
                                    return "Password must contain at least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
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
                          child: setUpButtonChild(signupState),
                          color: Theme.of(context).primaryColor,
                          onPressed: signupState is SignupLoadingState
                              ? null
                              : () async {
                                  if (_formKey.currentState.validate()) {
                                    if (_image != null) {
                                      FormData formData = FormData.fromMap({
                                        "image": await MultipartFile.fromFile(
                                          _image.path,
                                          filename: _filename,
                                        ),
                                        "email": _emailController.text,
                                        "phone_number":
                                            await SharedPref.getUserPhoneNum(),
                                        "username": _usernameController.text,
                                        "password": _passwordController.text,
                                        "name": _nameController.text,
                                      });
                                      signupBloc.add(SignupInitiatedEvent(
                                          formData: formData));
                                    } else {
                                      FormData formData = FormData.fromMap({
                                        "email": _emailController.text,
                                        "phone_number":
                                            await SharedPref.getUserPhoneNum(),
                                        "username": _usernameController.text,
                                        "password": _passwordController.text,
                                        "name": _nameController.text,
                                      });
                                      signupBloc.add(SignupInitiatedEvent(
                                          formData: formData));
                                    }
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
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
