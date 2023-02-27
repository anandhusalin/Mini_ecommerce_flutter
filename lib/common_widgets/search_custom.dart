import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:flutter/material.dart';

import '../core/constans/constants.dart';
import 'container_custom.dart';

class SearchBar extends StatelessWidget {
  final text;
  const SearchBar({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ContainerCustom(
        height: 40,
        width: MediaQuery.of(context).size.width - 120,
        child: Row(children: [
          Constants.width10,
          SizedBox(
              height: 15,
              width: 15,
              child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.dstIn),
                child: Image.asset(Constants.searchIcon),
              )),
          Constants.width10,
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: TextCustom(
              size: 15,
              text1: text,
              colorOfText: Colors.grey,
            ),
          ))
        ]),
      ),
    );
  }
}
