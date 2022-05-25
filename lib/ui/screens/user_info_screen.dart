import 'dart:developer';

import 'package:fiction_update/ui/screens/products_screen.dart';
import 'package:fiction_update/utils/help_functions.dart';
import 'package:fiction_update/utils/vars.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_button.dart';
import '../widgets/simple_textfield.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _autoValidate = false;
  String _email = "";
  String _phone = "";
  String _name = "";

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          _autoValidate = true;
        });
      }
      return;
    }
    _formKey.currentState!.save();
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductsScreen(),
        ),
      );
    } catch (e) {
      HelpFunctions().showToast(ErrorMessage.errorText, context);
      log(' error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fiction Apps Task',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              SimpleTextField(
                onSaved: (v) => _name = v!,
                hintText: "Name:",
                label: "Name",
                validationError:
                    Validator(rules: [RequiredRule(), MinLengthRule(3)]),
              ),
              const SizedBox(
                height: 12,
              ),
              SimpleTextField(
                onSaved: (v) => _phone = v!,
                hintText: "Phone:",
                label: "Phone",
                textInputType: TextInputType.phone,
                validationError:
                    Validator(rules: [RequiredRule(), MinLengthRule(11)]),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SimpleTextField(
                onSaved: (v) => _email = v!,
                hintText: "Email:",
                label: "Email",
                textInputType: TextInputType.emailAddress,
                validationError: Validator(rules: [
                  EmailRule(),
                ]),
              ),
              //////////////////////////////////////////////
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: 'Proceed',
                function: _submit,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
