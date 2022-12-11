import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoteWidget extends StatelessWidget {
  final double vote;
  const VoteWidget({required this.vote, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/star.svg'),
        const SizedBox(
          width: 6,
        ),
        Text(
          '${vote.toStringAsPrecision(2)}/10 IMDb',
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }
}
