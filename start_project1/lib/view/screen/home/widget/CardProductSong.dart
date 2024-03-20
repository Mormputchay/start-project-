import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../color.dart';
import '../../../../model/SongData.dart';

// ignore: non_constant_identifier_names
Widget CardProductSong(SongElement song, BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // nextScreen(
          //     context,
          //     SingSettingView(
          //       songElement: song,
          //     ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.maxFinite,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          color: TColor.red,
                          strokeWidth: 3,
                        ),
                      ),
                      imageUrl: "https://stage.cint-cam.com/${song.image}",
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/artist.svg",
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        song.artist.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  song.production.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: TColor.black,
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                    "assets/svg/music_pro.svg"),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${song.viewCount.toString()}M views",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 13),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
