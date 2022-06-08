import 'package:flutter/material.dart';

class BannerHome extends StatelessWidget {
  const BannerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                    "https://library.sportingnews.com/2021-08/rashford-greenwood-manchester-united-2021_fzb7eveoqdhl1u6mdq16yw2i5.jpg"),
                fit: BoxFit.cover)),
        width: double.infinity,
        height: 150);
  }
}
