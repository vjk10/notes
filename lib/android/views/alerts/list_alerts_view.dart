import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/android/views/alerts/add_alert_view.dart';
import 'package:notes/services/utils.dart';
import 'package:scientisst_db/scientisst_db.dart';

import '../../../services/notification_services.dart';
import '../../data/data.dart';
import '../../screens/settings_screen.dart';

class AllAlertsView extends StatefulWidget {
  const AllAlertsView({Key? key}) : super(key: key);

  @override
  State<AllAlertsView> createState() => _AllAlertsViewState();
}

class _AllAlertsViewState extends State<AllAlertsView> {
  bool alertsAvailable = false;
  late ScrollController _hideButtonController;
  bool _isVisible = true;
  late int alertsN = 0, _selectedIndex = 0;
  bool _optionsVisible = false;
  late String _notificationId, _notificationTitle;

  @override
  void initState() {
    getAlertsN();
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    checkIfAlertsAvailable();
    super.initState();
  }

  getAlertsN() async {
    ScientISSTdb.instance.collection("alerts").getDocuments().then((value) {
      setState(() {
        alertsN = value.length;
      });
    });
  }

  checkIfAlertsAvailable() async {
    await ScientISSTdb.instance
        .collection("alerts")
        .getDocuments()
        .then((value) {
      setState(() {
        alertsAvailable = value.length > 1;
      });
    });
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Visibility(
          visible: _isVisible,
          child: FloatingActionButton(
            heroTag: "fabTag",
            onPressed: () {
              Get.bottomSheet(
                SizedBox(
                  height: Get.height / 1.8,
                  child: const AddAlertView(),
                ),
                elevation: 10,
                enableDrag: true,
                isScrollControlled: true,
              );
            },
            backgroundColor: c.primaryContainer,
            child: Center(
              child: Icon(
                Icons.add_alert_outlined,
                color: c.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: c.background,
        toolbarHeight: 80,
        title: const Text(alertsTitle),
        automaticallyImplyLeading: false,
        actions: [
          //#54
          Visibility(
            visible: _optionsVisible,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _optionsVisible = !_optionsVisible;
                  _notificationId = _notificationTitle = '';
                });
              },
              icon: Icon(
                Icons.clear,
                color: c.onBackground,
              ),
            ),
          ),
          Visibility(
            visible: _optionsVisible,
            child: IconButton(
              onPressed: () async {
                checkIfAlertsAvailable();
                await NotificationService().endReminder(
                    int.parse(_notificationId), _notificationTitle);
                setState(() {
                  _optionsVisible = !_optionsVisible;
                  _notificationId = _notificationTitle = '';
                });
              },
              icon: Icon(
                Icons.delete_outline,
                color: c.error,
              ),
            ),
          ),
          Visibility(
            visible: !_optionsVisible && alertsN > 0,
            child: IconButton(
              onPressed: () async {
                await Utils()
                    .confirmationForAlertsDeletion(context, t, c)
                    .whenComplete(() {
                  getAlertsN();
                });
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: c.error,
              ),
            ),
          ),
          Visibility(
            visible: !_optionsVisible,
            child: IconButton(
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
              icon: Icon(
                Icons.settings_outlined,
                color: c.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: ScientISSTdb.instance.collection("alerts").watchDocuments(),
        builder:
            ((context, AsyncSnapshot<List<DocumentSnapshot>> alertSnapshot) {
          if (alertSnapshot.hasData) {
            return alertsGrid(alertSnapshot);
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  CustomScrollView alertsGrid(
      AsyncSnapshot<List<DocumentSnapshot>> alertsData) {
    return CustomScrollView(
      controller: _hideButtonController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                child: Card(
                  color: c.surfaceVariant,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: _optionsVisible
                        ? _selectedIndex == index
                            ? BorderSide(color: c.primary, width: 3)
                            : BorderSide(color: c.surfaceVariant, width: 2)
                        : BorderSide(color: c.surfaceVariant, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      HapticFeedback.heavyImpact();
                      setState(() {
                        _optionsVisible = !_optionsVisible;
                        _selectedIndex = index;
                        _notificationId = alertsData
                            .data![index].data["notificationID"]
                            .toString();
                        _notificationTitle =
                            alertsData.data![index].data["title"].toString();
                      });
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      title: Text(
                        alertsData.data![index].data["title"].toString(),
                        textAlign: TextAlign.start,
                        style: t.textTheme.headline6,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          alertsData.data![index].data["description"]
                              .toString(),
                          style: t.textTheme.subtitle1?.copyWith(
                            color: c.onSecondaryContainer,
                          ),
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.repeat_outlined,
                            color: c.onSurfaceVariant,
                            size: 12,
                          ),
                          Text(
                            alertsData.data![index].data["interval"].toString(),
                            style: t.textTheme.bodyMedium?.copyWith(
                              color: c.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: alertsData.data!.length,
          ),
        )
      ],
    );
  }
}
