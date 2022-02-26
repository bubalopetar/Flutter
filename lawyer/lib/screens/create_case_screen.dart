import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:lawyer/providers/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/cases.dart';

class CreateCaseScreen extends StatefulWidget {
  static const screenName = '/create-case';
  const CreateCaseScreen({Key? key}) : super(key: key);

  @override
  _CreateCaseScreenState createState() => _CreateCaseScreenState();
}

class _CreateCaseScreenState extends State<CreateCaseScreen> {
  final _form = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    'attachmentDate': DateTime.now().add(const Duration(days: 1))
  };
  dynamic _caseToUpdate;
  var _isInit = true;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _caseToUpdate = ModalRoute.of(context)!.settings.arguments;
      if (_caseToUpdate != null) {
        formData['attachmentDate'] = _caseToUpdate.attachmentDate;
      }
    }
    localizations = AppLocalizations.of(context)!;
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _buildInputForm(),
        ),
      ),
    );
  }

  Form _buildInputForm() {
    return Form(
      key: _form,
      child: SingleChildScrollView(
          child: Column(
        children: [
          _buildBusinessNumberInput(),
          _buildInternalNumberInput(),
          _buildClientInput(),
          _buildAttachmentDateAndDeadline(),
          _buildDescriptionInput()
        ],
      )),
    );
  }

  Row _buildAttachmentDateAndDeadline() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ..._buildAttachmentDateLabelAndPicker(),
        _buildDeadlineInputField(),
      ],
    );
  }

  List _buildAttachmentDateLabelAndPicker() {
    var locale = Localizations.localeOf(context);

    return [
      Text(localizations.startingAt),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 50),
        child: GestureDetector(
          child: Text(
              DateFormat('EEE, d.MM.y', locale.toString())
                  .format(formData['attachmentDate']),
              style: Theme.of(context).textTheme.headline6),
          onTap: () async {
            var pickedDate = await showDatePicker(
                context: context,
                initialDate: formData['attachmentDate'],
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                locale: locale);
            setState(() {
              formData['attachmentDate'] = pickedDate as DateTime;
            });
          },
        ),
      ),
    ];
  }

  Expanded _buildDeadlineInputField() {
    return Expanded(
      child: TextFormField(
        initialValue: _caseToUpdate?.deadline.toString(),
        validator: _deadlineValidator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: localizations.deadline,
            hintText: localizations.numberOfDays,
            hintMaxLines: 2,
            errorMaxLines: 3),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onSaved: (value) {
          formData['deadline'] = int.parse(value as String);
        },
      ),
    );
  }

  String? _deadlineValidator(value) {
    if (value!.isEmpty || value.trim() == '') {
      return localizations.mustNotBeEmpty;
    }
    if (int.parse(value) == 0) {
      return localizations.wrongInput;
    }
    var attachmentDate = formData['attachmentDate'] as DateTime;

    var deadline = attachmentDate.add(Duration(days: int.parse(value)));
    var today = DateTime.now();
    if (deadline.isBefore(today)) {
      return localizations.deadlinePassed;
    }
    return null;
  }

  Padding _buildDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        initialValue: _caseToUpdate?.description ?? formData['description'],
        validator: (value) {
          if (value!.length > Cases.descriptionLenght) {
            return "${localizations.noLongerThan} ${Cases.descriptionLenght} ${localizations.chars}!";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: localizations.desc,
          hintText: localizations.enterDesc,
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        onFieldSubmitted: (_) {
          _saveForm();
        },
        onSaved: (value) {
          formData['description'] = value as String;
        },
      ),
    );
  }

  TextFormField _buildClientInput() {
    return TextFormField(
      initialValue: _caseToUpdate?.client ?? formData['client'],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: localizations.client,
        hintText: localizations.clientName,
      ),
      validator: (value) {
        var emptyOrSmaller =
            _checkIfInputEmptyOrSmallerThan(value, Cases.textFieldsLenght);
        return emptyOrSmaller;
      },
      onSaved: (value) {
        formData['client'] = value as String;
      },
      keyboardType: TextInputType.name,
    );
  }

  TextFormField _buildInternalNumberInput() {
    return TextFormField(
      initialValue: _caseToUpdate?.internalNumber ?? formData['internalNumber'],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: localizations.internalNumber,
        hintText: localizations.enterInternalNumber,
      ),
      validator: (value) {
        var emptyOrSmaller =
            _checkIfInputEmptyOrSmallerThan(value, Cases.textFieldsLenght);
        return emptyOrSmaller;
      },
      onSaved: (value) {
        formData['internalNumber'] = value as String;
      },
    );
  }

  TextFormField _buildBusinessNumberInput() {
    return TextFormField(
      initialValue: _caseToUpdate?.businessNumber ?? formData['businessNumber'],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: localizations.businessNumber,
        hintText: localizations.enterBusinessNumber,
      ),
      validator: (value) {
        var emptyOrSmaller =
            _checkIfInputEmptyOrSmallerThan(value, Cases.textFieldsLenght);
        return emptyOrSmaller;
      },
      onSaved: (value) {
        formData['businessNumber'] = value as String;
      },
    );
  }

  dynamic _checkIfInputEmptyOrSmallerThan(value, length) {
    if (value!.isEmpty || value.trim() == '') {
      return localizations.mustNotBeEmpty;
    }
    if (value!.length > length) {
      return '${localizations.noLongerThan} ${Cases.textFieldsLenght} ${localizations.chars}';
    }
    return null;
  }

  void _saveForm() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      var caseDao = Provider.of<CaseDao>(context, listen: false);
      if (_caseToUpdate != null) {
        _caseToUpdate = _caseToUpdate.copyWith(
          businessNumber: formData['businessNumber'],
          internalNumber: formData['internalNumber'],
          client: formData['client'],
          attachmentDate: formData['attachmentDate'],
          deadline: formData['deadline'],
          deadlineDate: formData['attachmentDate']
              .add(Duration(days: formData['deadline'])),
          description: formData['description'],
        );

        await caseDao.updateCase(_caseToUpdate);
      } else {
        var caseToInsert = CasesCompanion(
          businessNumber: drift.Value(formData['businessNumber']),
          internalNumber: drift.Value(formData['internalNumber']),
          client: drift.Value(formData['client']),
          attachmentDate: drift.Value(formData['attachmentDate']),
          deadline: drift.Value(formData['deadline']),
          description: drift.Value(formData['description']),
          deadlineDate: drift.Value(formData['attachmentDate']
              .add(Duration(days: formData['deadline']))),
        );

        await caseDao.insertCase(caseToInsert);
      }
      Navigator.of(context).pop();
    }
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        IconButton(
          onPressed: () {
            _saveForm();
          },
          icon: const Icon(Icons.save),
        ),
      ]),
    );
  }
}
