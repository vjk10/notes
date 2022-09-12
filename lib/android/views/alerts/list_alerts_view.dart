import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:notes/android/views/alerts/add_alert_view.dart';
import 'package:notes/services/notification_services.dart';
import 'package:notes/services/utils.dart';
import 'package:scientisst_db/scientisst_db.dart';

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

  @override
  void initState() {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: alertsAvailable,
                child: FloatingActionButton(
                  onPressed: () {
                    Utils().confirmationForAlertsDeletion(context, t, c);
                  },
                  backgroundColor: c.errorContainer,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.delete_outline,
                          color: c.onErrorContainer,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Icon(
                            Icons.notifications,
                            color: c.onErrorContainer,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
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
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: c.background,
        toolbarHeight: 80,
        title: const Text('alerts'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
            icon: Icon(
              Icons.settings_outlined,
              color: c.onSurface,
            ),
          )
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
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                child: Card(
                  color: c.surfaceVariant,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    leading: Icon(
                      Icons.alarm_on_rounded,
                      color: c.onBackground,
                      size: 36,
                    ),
                    title: Text(
                      alertsData.data![index].data["title"].toString(),
                      textAlign: TextAlign.start,
                      style: t.textTheme.headline6,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        alertsData.data![index].data["description"].toString(),
                        style: t.textTheme.subtitle1?.copyWith(
                          color: c.onSecondaryContainer,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {
                          checkIfAlertsAvailable();
                          var id = alertsData
                              .data![index].data["notificationID"]
                              .toString();
                          NotificationService().endReminder(int.parse(id),
                              alertsData.data![index].data["title"].toString());
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: c.error,
                        ),
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
