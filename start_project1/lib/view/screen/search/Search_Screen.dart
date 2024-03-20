import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:start_project1/color.dart';

import '../../../constants/base_constants.dart';
import '../../../model/SongData.dart';
import '../../widget/tab_text_button.dart';
import '../home/widget/CardProductSong.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectTab = 0;
  List<SongElement> songs = [];

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  static Future<SongData> fetchData(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return SongData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print("error: $e");
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        barrierDismissible: false,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'error : $e',
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.primary,
        leading: IconButton(
            onPressed: () {}, icon: SvgPicture.asset("assets/svg/back.svg")),
        title: Text(
          "Search",
          style: TextStyle(
              color: TColor.black, fontSize: 21, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Container(
                width: double.maxFinite,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: TColor.black,
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/svg/search_svg.svg",
                            width: 18,
                            height: 18,
                          )),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TabTextButton(
                        title: "Song",
                        isActive: selectTab == 0,
                        onPressed: () {
                          setState(() {
                            selectTab = 0;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      TabTextButton(
                        title: "Product",
                        isActive: selectTab == 1,
                        onPressed: () {
                          setState(() {
                            selectTab = 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 0.5,
                    color: TColor.black.withOpacity(0.5),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            if (selectTab == 0)
              FutureBuilder<SongData>(
                future: fetchData(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    SongData songData = snapshot.data!;
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: songData.data.songs.length,
                          itemBuilder: (context, index) {
                            SongElement song = songData.data.songs[index];
                            return CardProductSong(song, context);
                          },
                        ),
                      ),
                    );
                  } else {
                    // Data is still loading
                    return const Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        )),
                      ],
                    );
                  }
                },
              ),
            if (selectTab == 1)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 185),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                            "https://www.verywellfamily.com/thmb/mGK8pZrsEZ77xYv5FGCB2T8ku6c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/vwf-best-mp3-players-for-kids-of-2023-tout-f77c3754dbeb45caa310ee80079cd60c.jpg")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "M AUDIO MONITOR SPertyuihghutyuiogh",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('\$450'),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svg/star.svg",
                                                  width: 12,
                                                  height: 12,
                                                  fit: BoxFit.contain,
                                                ),
                                                const SizedBox(width: 5),
                                                const Text('4.3'),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
