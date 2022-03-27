import 'package:demo_chat/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/fields/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (context, loginModel, child) =>
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                height: size.height*0.8,
                width: size.width,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildIdField(size, loginModel),
            buildPasswordField(size, loginModel),
            buildLoginButton(size, loginModel),
          ]),
              ),
        ),
      ),
    );
  }

  Padding buildLoginButton(Size size, LoginProvider loginModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
      child: SizedBox(
        height: size.width * 0.12,
        width: size.width * 0.9,
        child: StreamBuilder<bool>(
            stream: loginModel.validLogin,
            builder: (context, snapshot) {
              return ElevatedButton(
                onPressed: !snapshot.hasData
                    ? null
                    : () => loginModel.callLoginControl(context),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white, fontSize: size.width * 0.045),
                ),
              );
            }),
      ),
    );
  }

  buildIdField(Size size, LoginProvider loginModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: StreamBuilder<String>(
        stream: loginModel.id,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: size.width * 0.02),
            child: InputField(
              errSnapshot: snapshot,
              textEditingController: loginModel.mobileNumberController,
              onChanged: loginModel.changeuserMobileNo,
              labelText: "Mobile Number",
              textInputType: TextInputType.number,
              filteringTextInputFormatter:
                  FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
              lengthLimitingTextInputFormatter:
                  LengthLimitingTextInputFormatter(10),
              obscureText: false,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
            ),
          );
        },
      ),
    );
  }

  buildPasswordField(Size size, LoginProvider loginModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: StreamBuilder<String>(
        stream: loginModel.password,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: size.width * 0.02),
            child: InputField(
              errSnapshot: snapshot,
              textEditingController: loginModel.passwordController,
              onChanged: loginModel.changePassword,
              labelText: "Enter your password ",
              textInputType: TextInputType.visiblePassword,
              filteringTextInputFormatter:
                  FilteringTextInputFormatter(RegExp("[ ]"), allow: false),
              lengthLimitingTextInputFormatter:
                  LengthLimitingTextInputFormatter(16),
              obscureText: true,
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
            ),
          );
        },
      ),
    );
  }
}
