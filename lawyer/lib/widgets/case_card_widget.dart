import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/database.dart';
import '../screens/create_case_screen.dart';
import '../providers/case_helper.dart';

enum DismissAction { archive, delete }

class CaseCard extends StatefulWidget {
  const CaseCard({
    Key? key,
    required this.caseItem,
    required this.deadlineStatus,
  }) : super(key: key);

  final Case caseItem;
  final DeadlineStatus deadlineStatus;
  static const Map<DeadlineStatus, dynamic> _getColor = {
    DeadlineStatus.lastDay: Colors.red,
    DeadlineStatus.penultimateDay: Colors.orangeAccent,
    DeadlineStatus.passed: Colors.lightGreenAccent,
    DeadlineStatus.notYetStarted: Colors.lightBlueAccent,
  };

  @override
  State<CaseCard> createState() => _CaseCardState();
}

class _CaseCardState extends State<CaseCard> {
  DismissAction action = DismissAction.delete;
  Future<bool?> _confirmDismiss(direction, context, caseDao) {
    if (direction == DismissDirection.startToEnd) {
      return _showConfirmationDialog(
          context,
          widget.caseItem,
          'Jeste li sigurni da želite ${widget.caseItem.isArchived ? 'vratiti arhivirani' : 'arhivirati'} predmet?',
          caseDao.toggleCaseArchive);
    } else {
      return _showConfirmationDialog(context, widget.caseItem,
          'Jeste li sigurni da želite izbrisati predmet?', caseDao.deleteCase);
    }
  }

  Future<bool?> _showConfirmationDialog(context, caseItem, title, daoFunction) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(title: Text(title), actions: [
              TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop(false)),
              TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    daoFunction(caseItem);
                    Navigator.of(context).pop(true);
                  })
            ]));
  }

  @override
  Widget build(BuildContext context) {
    var caseDao = Provider.of<CaseDao>(context, listen: false);
    return Dismissible(
      onUpdate: (DismissUpdateDetails details) {
        if (details.direction == DismissDirection.endToStart) {
          setState(() {
            action = DismissAction.delete;
          });
        } else {
          setState(() {
            action = DismissAction.archive;
          });
        }
      },
      confirmDismiss: (direction) =>
          _confirmDismiss(direction, context, caseDao),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          caseDao.deleteCase(widget.caseItem);
        }
        if (direction == DismissDirection.startToEnd) {
          caseDao.toggleCaseArchive(widget.caseItem);
        }
      },
      background: _buildArchiveAndDeleteDismissable(action),
      key: ValueKey(widget.caseItem.id),
      child: _buildExpansionTile(context),
    );
  }

  ExpansionTile _buildExpansionTile(BuildContext context) {
    var status = widget.caseItem.getDeadlineStatus();
    return ExpansionTile(
      key: UniqueKey(),
      collapsedBackgroundColor: status == DeadlineStatus.multipleDays
          ? Theme.of(context).cardTheme.color
          : CaseCard._getColor[status],
      childrenPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      tilePadding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      title: _buildExpansionTileTitle(context),
      subtitle: _buildExpansionTileSubtitle(context),
      children: _buildExpansionTileAcordion(context),
    );
  }

  Text _buildExpansionTileSubtitle(BuildContext context) {
    return Text(
        widget.caseItem
            .getSubtitleText(status: widget.deadlineStatus, context: context),
        style: Theme.of(context).textTheme.headline6);
  }

  List<Widget> _buildExpansionTileAcordion(BuildContext context) {
    return [
      const Divider(thickness: 2),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: FittedBox(child: Text('Poslovni br.')),
          ),
          Text(widget.caseItem.businessNumber,
              style: Theme.of(context).textTheme.headline6),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text('Interni br.'),
          ),
          FittedBox(
              child: Text(widget.caseItem.internalNumber,
                  style: Theme.of(context).textTheme.headline6)),
        ],
      ),
      if (widget.caseItem.description.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 100),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Text(
                widget.caseItem.description,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
              )),
            ),
          ),
        )
    ];
  }

  Row _buildExpansionTileTitle(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.person,
          ),
        ),
        FittedBox(
          child: Text(
            widget.caseItem.client,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CreateCaseScreen.screenName,
                arguments: widget.caseItem);
          },
          icon: const Icon(Icons.edit),
        )
      ],
    );
  }

  Container _buildArchiveAndDeleteDismissable(DismissAction action) {
    if (action == DismissAction.archive) {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                  widget.caseItem.isArchived ? 'Vrati iz arhive' : 'Arhiviraj'),
            ),
            const Icon(Icons.archive)
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('Izbriši'),
            ),
            Icon(Icons.delete)
          ],
        ),
      );
    }
  }
}
