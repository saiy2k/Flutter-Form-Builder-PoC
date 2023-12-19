import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_poc/components/custom_input.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SubmitButtonAlwaysEnable(),
      // home: SubmitButtonDisabled(),
      // home: CustomFormControl(),
    );
  }
}

class SubmitButtonAlwaysEnable extends StatelessWidget {
  SubmitButtonAlwaysEnable({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit button always enabled')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'TextField [No rules]',
                textAlign: TextAlign.left,
              ),
              const Gap(8),
              FormBuilderTextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.0),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.0),
                    borderSide: const BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.0),
                    borderSide: const BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(bottom: 8, left: 24),
                ),
                name: 'textField',
                onChanged: (val) {
                  print(val);
                },
              ),
              const Gap(16),
              FormBuilderTextField(
                decoration: const InputDecoration(label: Text('TextField2 [Should contain hey]')),
                name: 'textField2',
                onChanged: (val) {
                  print(val);
                },
                validator: (value) {
                  if (!(value != null && value.contains("hey"))) {
                    return 'This field should contain the string \'hey\'';
                  }
                },
              ),
              const Gap(16),
              FormBuilderTextField(
                name: 'emailField',
                decoration: InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ]),
                onChanged: (val) {
                  print(val);
                },
              ),
              const Gap(16),
              FormBuilderDropdown(
                name: 'dropDown',
                decoration: const InputDecoration(label: Text('Regular dropdown')),
                items: ["Hey", "World", "Hey world"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (val) {
                  print(val);
                },
              ),
              const Gap(16),
              MaterialButton(
                color: Colors.amber,
                child: const Text('Submit'),
                onPressed: () {
                  bool? isGood = _formKey.currentState?.saveAndValidate();
                  print('isGood');
                  print(isGood);
                  debugPrint(_formKey.currentState?.value.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitButtonDisabled extends StatefulWidget {
  const SubmitButtonDisabled({super.key});

  @override
  State<SubmitButtonDisabled> createState() => _SubmitButtonDisabledState();
}

class _SubmitButtonDisabledState extends State<SubmitButtonDisabled> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit button disabled')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          onChanged: () {
            print('++++++++++++++++++++ changed +++++++++++++++++++++');
            setState(() {
              isValid = _formKey.currentState != null && _formKey.currentState!.isValid;
            });
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'textField',
                onChanged: (val) {
                  print(val);
                  _formKey.currentState?.save();
                },
              ),
              // FormBuilderTextField(
              //   name: 'textField2',
              //   onChanged: (val) {
              //     print(val);
              // _formKey.currentState?.save();
              //   },
              //   validator: (value) {
              //     if(!(value != null && value.contains("hey"))) {
              //       return 'This field should contain the string \'hey\'';
              //     }
              //   },
              // ),
              FormBuilderTextField(
                name: 'emailField',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ]),
                onChanged: (val) {
                  print(val);
                  _formKey.currentState?.save();
                },
              ),
              FormBuilderDropdown(
                name: 'dropDown',
                items: ["Hey", "World", "Hey world"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                onChanged: (val) {
                  print(val);
                  _formKey.currentState?.save();
                },
              ),
              MaterialButton(
                color: Colors.amber,
                child: const Text('Submit'),
                onPressed: !isValid
                    ? null
                    : () {
                        _formKey.currentState?.saveAndValidate();
                        // debugPrint(_formKey.currentState?.value.toString());
                        print("\n");
                        print("\n");
                        _formKey.currentState?.errors.toString();
                        print("\n");
                        print(_formKey.currentState?.errors.toString());
                      },
              ),

              MaterialButton(
                color: Colors.amber,
                child: const Text('Patch values'),
                onPressed: () {
                  _formKey.currentState?.patchValue({
                    'textField': 'hellow',
                    'emailField': 'hey@gmail.com',
                    'dropDown': 'World',
                  });

                  _formKey.currentState?.save();
                },
              ),

              Text(_formKey.currentState == null
                  ? 'Null'
                  : _formKey.currentState?.errors.toString() == null
                      ? 'No errors'
                      : _formKey.currentState!.errors.toString()),

              Text(isValid ? 'valid' : 'nope'),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFormControl extends StatelessWidget {
  CustomFormControl({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit button always enabled')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderField<String?>(
                name: 'email',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                builder: (FormFieldState field) {
                  print("\n\n\n");
                  print("errorText");
                  print(field.errorText);

                  print("\nhasError");
                  print(field.hasError);

                  print("\nisValid");
                  print(field.isValid);
                  print("\n\n\n");
                  return CustomInput(
                    label: 'Email',
                    error: field.errorText,
                    onChange: (val) {
                      field.didChange(val);
                      field.validate();
                    },
                    value: field.value,
                  );
                },
              ),
              MaterialButton(
                  color: Colors.purpleAccent,
                  child: Text('Submit'),
                  onPressed: () {
                    _formKey.currentState?.saveAndValidate();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
