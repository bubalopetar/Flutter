import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lawyer/notifications/notifications_alarm_manager.dart';
import 'package:lawyer/screens/create_case_screen.dart';
import 'package:lawyer/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/localization_service.dart';
import '../providers/database.dart';
import '../widgets/case_card_widget.dart';
import '../providers/case_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flag/flag.dart';

class CasesListScreen extends StatefulWidget {
  static const screenName = '/cases';
  const CasesListScreen({Key? key}) : super(key: key);

  @override
  State<CasesListScreen> createState() => _CasesListScreenState();
}

class _CasesListScreenState extends State<CasesListScreen> {
  late CustomTheme theme;
  late CaseDao caseDao;
  var showArchived = false;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      theme = Provider.of<CustomTheme>(context, listen: false);
      caseDao = Provider.of<CaseDao>(context, listen: false);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void showPickerforDate(BuildContext context, localizations) async {
    var prefs = Provider.of<SharedPreferences>(context, listen: false);
    var notificationTime = prefs.getString('notificationTime');

    var time = await showTimePicker(
        helpText: localizations.currentNotificationTime,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(notificationTime!.substring(0, 2)),
            minute: int.parse(notificationTime.substring(3, 5))));
    if (time != null) {
      await prefs.setString('notificationTime', time.format(context));
      setAndroidAlarm(prefs);
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
      drawer: buildSideDrawer(localizations, context),
      bottomNavigationBar: CustomBottomAppBar(theme: theme, caseDao: caseDao),
      body: _streamListItemBuilder(caseDao, showArchived),
    );
  }

  Drawer buildSideDrawer(
      AppLocalizations? localizations, BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => theme.changeTheme(),
              title: Text(localizations!.changeTheme),
              trailing: const Icon(Icons.light_mode),
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.showArchived),
              trailing: Switch(
                  value: showArchived,
                  onChanged: (value) {
                    showArchived = value;
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
            ),
            const Divider(),
            ListTile(
              onTap: () => showPickerforDate(context, localizations),
              title: Text(localizations.changeNotificationsTime),
              trailing: const Icon(Icons.notifications_active_sharp),
            ),
            const Divider(),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...LocalizationService.supportedLocales
                      .map((e) => GestureDetector(
                            onTap: () => Provider.of<LocalizationService>(
                                    context,
                                    listen: false)
                                .changeActiveLocalization(
                                    e.languageCode, e.countryCode!),
                            child: Flag.fromString(e.countryCode!,
                                height: 20, width: 40),
                          ))
                      .toList()
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Case>> _streamListItemBuilder(
      CaseDao caseDao, showArchived) {
    return StreamBuilder(
      stream:
          showArchived ? caseDao.archivedEntries : caseDao.allCaseEntriesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          var cases = snapshot.data as List<Case>;
          if (cases.isNotEmpty) {
            return CasesList(cases: cases);
          }
        }
        if (showArchived) {
          return Center(
            child: Text(AppLocalizations.of(context)!.emptyArchive),
          );
        }
        return const AddItem();
      },
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
    required this.theme,
    required this.caseDao,
  }) : super(key: key);

  final CustomTheme theme;
  final CaseDao caseDao;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu)),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreateCaseScreen.screenName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class CasesList extends StatelessWidget {
  const CasesList({
    Key? key,
    required this.cases,
  }) : super(key: key);

  final List<Case> cases;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final caseItem = cases[index];
        return CaseCard(
          caseItem: caseItem,
          deadlineStatus: caseItem.getDeadlineStatus(),
        );
      },
      itemCount: cases.length,
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CreateCaseScreen.screenName);
      },
      child: Center(
        child: Text(AppLocalizations.of(context)!.addNewItem),
      ),
    );
  }
}
