import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../color.dart';
import '../../../../model/SongData.dart';

Widget buildCardProductData(Size media, Product product) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: media.width * 0.40,
    width: media.width / 2.5,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: media.width * 0.40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: Expanded(
                        child: CircularProgressIndicator(
                          color: TColor.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    imageUrl:
                        "https://stage.cint-cam.com/${product.image.toString()}",
                    width: media.width / 2.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${product.categoryId.toString()}",
                          style: TextStyle(
                              fontSize: 15,
                              color: TColor.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                            ),
                            Text(
                              product.minPrice.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: TColor.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
