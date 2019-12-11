import 'package:cobaaaa_dulu/app/sign_in/sign_in_button.dart';
import 'package:cobaaaa_dulu/app/sign_in/validators.dart';
import 'package:cobaaaa_dulu/common_widgets/form_submit_button.dart';
import 'package:cobaaaa_dulu/services/auth.dart';
import 'package:flutter/material.dart';

enum EmailSignFormType { sigIn, register }

class SignInPage extends StatefulWidget with EmailAndPasswordValidators {
  SignInPage({@required this.auth});
  final AuthBase auth;
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  EmailSignFormType _formType = EmailSignFormType.sigIn;
  bool _submitted = false;
  bool _isLoading = false;
  final Auth auth = Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingCompleted() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignFormType.sigIn
          ? EmailSignFormType.register
          : EmailSignFormType.sigIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignFormType.sigIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      await auth.signAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[110],
      body: buildStack(context),
    );
  }

  void _updateState() {
    print('email: $_email, password:$_password');
    setState(() {});
  }

  Widget buildStack(BuildContext context) {
    final secondaryText = _formType == EmailSignFormType.sigIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';
    return Stack(
      children: <Widget>[
        Positioned(
          right: -getSmallDiameter(context) / 3,
          top: -getSmallDiameter(context) / 3,
          child: Container(
            width: getSmallDiameter(context),
            height: getSmallDiameter(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.cyanAccent, Colors.green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
        ),
        Positioned(
          top: -getBigDiameter(context) / 5,
          left: -getBigDiameter(context) / 4,
          child: Container(
            child: Center(
              child: Text(
                "Log In",
                style: TextStyle(
                    fontFamily: "earwig", color: Colors.white, fontSize: 50),
              ),
            ),
            height: getBigDiameter(context),
            width: getBigDiameter(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.cyanAccent, Colors.green],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned(
          right: -getBigDiameter(context) / 2,
          bottom: -getBigDiameter(context) / 1.5,
          child: Container(
            height: getBigDiameter(context),
            width: getBigDiameter(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.fromLTRB(20, 290, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    _buildPasswordTextField()
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                    child: Text(
                      "Forget Passowrd ?",
                      style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                    ),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildFormSubmit(context),
                    Row(
                      children: <Widget>[
                        SignInButton(
                          onPressed: _signInWithFacebook,
                          elevation: 0,
                          text: "fonts/logo-fb-2.png",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: _signInWithGoogle,
                          mini: true,
                          elevation: 0,
                          child: Image(
                            image: AssetImage("fonts/google-logo.png"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: !_isLoading ? _toogleFormType : null,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        secondaryText,
                        style: TextStyle(color: Colors.greenAccent),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Center(
                child: RaisedButton(
                  child: Text("Guest"),
                  onPressed: _signInAnonymously,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);

    return TextField(
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        icon: Icon(
          Icons.vpn_key,
          color: Colors.greenAccent,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent)),
        labelStyle: TextStyle(color: Colors.greenAccent),
        labelText: "Password",
      ),
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          enabled: _isLoading == false,
          icon: Icon(Icons.email, color: Colors.greenAccent),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent)),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.greenAccent),
          errorText: showErrorText ? widget.invalidEmailErrorText : null),
      controller: _emailController,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingCompleted,
    );
  }

  SizedBox buildFormSubmit(BuildContext context) {
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    final primaryText =
        _formType == EmailSignFormType.sigIn ? 'Sign In' : 'Create an account';
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      child: Container(
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: SubmitButton(
              onTap: submitEnabled ? _submit : null,
              splColor: Colors.greenAccent,
              text: primaryText,
              textColor: Colors.white,
            )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.green],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
      ),
    );
  }
}
