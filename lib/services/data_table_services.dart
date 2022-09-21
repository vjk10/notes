import 'package:flutter/material.dart';

class DataTableServices {
  initColumns(ColorScheme c, ThemeData t, List<DataColumn> columns) {
    return columns = [
      // DataColumn(
      //     label: Text(
      //   "#",
      //   style: t.textTheme.subtitle1?.copyWith(color: c.onPrimaryContainer),
      // )),
      DataColumn(
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.label_outline_rounded,
              size: 14,
              color: c.onPrimaryContainer,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Label",
              style:
                  t.textTheme.subtitle1?.copyWith(color: c.onPrimaryContainer),
            )
          ],
        ),
      ),
      DataColumn(
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payments_outlined,
              color: c.onPrimaryContainer,
              size: 14,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Amount",
              style:
                  t.textTheme.subtitle1?.copyWith(color: c.onPrimaryContainer),
            )
          ],
        ),
      ),
      DataColumn(
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 14,
              color: c.onPrimaryContainer,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Description",
              style:
                  t.textTheme.subtitle1?.copyWith(color: c.onPrimaryContainer),
            )
          ],
        ),
      ),
    ];
  }
}
