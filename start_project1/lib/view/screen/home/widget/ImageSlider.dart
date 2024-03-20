import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../color.dart';
import '../../../../data/images.dart';

// ignore: non_constant_identifier_names
Container ImageSlider(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            color: TColor.primary,
            strokeWidth: 2,
          ),
        ),
        imageUrl: images[index],
        fit: BoxFit.cover,
      ),
    ),
  );
}
