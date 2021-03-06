// ignore: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zakazi/src/data/salonsData.dart';
import 'package:zakazi/src/screens/details/detailsScreen.dart';

import 'nearestSalonCard.dart';

// ignore: use_key_in_widget_constructors
class NearestSalons extends StatefulWidget {
  @override
  State<NearestSalons> createState() => _NearestSalonsState();
}

class _NearestSalonsState extends State<NearestSalons> {
  void getSalonById(String id) async {
    final salonData = SalonsData();

    await salonData.getSalonsById(id);

    if (salonData.loading) {
      Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: SalonDetailsArguments(salon: salonData.salon),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final salons = Provider.of<SalonsData>(context);
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10.w);
        },
        itemCount: salons.salons.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return NearestSalonCard(
            salon: salons.salons[index],
            press: () => {
              getSalonById(salons.salons[index].id),
            },
          );
        },
      ),
    );
  }
}
