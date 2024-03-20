import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:start_project1/view/screen/home/widget/BuilderAppBar.dart';
import 'package:start_project1/view/screen/home/widget/CardProductSong.dart';
import 'package:start_project1/view/screen/home/widget/ImageSlider.dart';
import 'package:start_project1/view/screen/home/widget/buildCardProductData.dart';

import '../../../color.dart';
import '../../../constants/base_constants.dart';
import '../../../data/images.dart';
import '../../../model/SongData.dart';
import '../../widget/text_viewAll.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = CarouselController();
  int activeIndex = 0;
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  String userName = "";
  String password = "";
  getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userName = sp.getString("username").toString();
      password = sp.getString("password").toString();
    });
  }

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
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: BuilderAppBar(media: media),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            color: TColor.primary,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 175,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: images.length,
                      carouselController: controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          }),
                      itemBuilder: (context, index, realIdx) {
                        return ImageSlider(index);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  builderIndicatior(),
                  const Text_ViewAll(
                    title: "Product",
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<SongData>(
                    future: fetchData(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        SongData songData = snapshot.data!;
                        return Container(
                          height: 230,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: songData.data.products.length,
                              itemBuilder: (context, index) {
                                Product product = songData.data.products[index];
                                return buildCardProductData(media, product);
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ));
                      }
                    },
                  ),
                  const Text_ViewAll(
                    title: "Song",
                  ),
                  FutureBuilder<SongData>(
                    future: fetchData(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        SongData songData = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: songData.data.songs.length,
                          itemBuilder: (context, index) {
                            SongElement song = songData.data.songs[index];
                            return CardProductSong(song, context);
                          },
                        );
                      } else {
                        // Data is still loading
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget builderIndicatior() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: images.length,
          onDotClicked: animateToSlide,
          effect: JumpingDotEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: TColor.black,
              dotColor: Colors.black12),
        ),
      ],
    );
  }

  animateToSlide(int index) {
    controller.animateToPage(index);
  }
}
