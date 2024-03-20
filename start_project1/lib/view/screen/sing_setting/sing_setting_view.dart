import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:start_project1/color.dart';
import 'package:start_project1/model/SongData.dart';

class SingSettingView extends StatefulWidget {
  SongElement songElement;
  SingSettingView({super.key, required this.songElement});

  @override
  State<SingSettingView> createState() => _SingSettingViewState();
}

class _SingSettingViewState extends State<SingSettingView> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: TColor.primary,
      appBar: AppBar(
        backgroundColor: TColor.primary,
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          color: TColor.primary,
                          strokeWidth: 3,
                        ),
                      ),
                      imageUrl:
                          "https://stage.cint-cam.com/${widget.songElement.image}",
                      width: media.width,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Expanded(
                        child: Text(
                          widget.songElement.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: TColor.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Expanded(
                        child: Text(
                          widget.songElement.artist,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: TColor.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Expanded(
                        child: Text(
                          widget.songElement.production,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: TColor.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.55),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Record video',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: TColor.black),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.grey.withOpacity(0.5),
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
