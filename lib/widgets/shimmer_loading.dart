import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ShimmerLoading extends StatelessWidget {
  double? height;
  double? width;
  double? borderRadius;

  ShimmerLoading({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  factory ShimmerLoading.square(double height, [double? borderRadius]) {
    return ShimmerLoading(
      height: height,
      width: height,
      borderRadius: borderRadius!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: const Color(0xffC4C4C4),
        highlightColor: Colors.white,
        child: Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
          ),
        ),
      ),
    );
  }
}
