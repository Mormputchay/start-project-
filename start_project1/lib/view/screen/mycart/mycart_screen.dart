import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../color.dart';
import '../../../data/Mycart.dart';
import '../../../utils/next_screen.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});
  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final listKey = GlobalKey<AnimatedListState>();
  final checkcardprice = true;
  List<MyCart> cart = [
    MyCart(
        image:
            "https://i.pinimg.com/736x/29/61/c3/2961c3b55c9bbd1ac2f3ab3c8a190d28.jpg",
        title: "Torch USB Microphone",
        subtitle: "Black, M",
        price: 38,
        counter: 1),
    MyCart(
        image:
            "https://i.pinimg.com/736x/29/61/c3/2961c3b55c9bbd1ac2f3ab3c8a190d28.jpg",
        title: "Torch USB Microphone",
        subtitle: "Black, M",
        price: 38,
        counter: 1),
    MyCart(
        image:
            "https://i.pinimg.com/736x/29/61/c3/2961c3b55c9bbd1ac2f3ab3c8a190d28.jpg",
        title: "Torch USB Microphone",
        subtitle: "Black, M",
        price: 38,
        counter: 1),
    MyCart(
        image:
            "https://i.pinimg.com/736x/29/61/c3/2961c3b55c9bbd1ac2f3ab3c8a190d28.jpg",
        title: "Torch USB Microphone",
        subtitle: "Black, M",
        price: 38,
        counter: 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColor.primary,
      appBar: AppBar(
        backgroundColor: TColor.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            backReplace(context);
          },
          icon: SvgPicture.asset(
            "assets/svg/back.svg",
            width: 20,
            height: 14,
          ),
        ),
        centerTitle: true,
        title: const Text('My Cart'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedList(
                key: listKey,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                initialItemCount: cart.length,
                itemBuilder: (context, index, animation) {
                  return CardMyCart(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CardMyCart(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
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
                        color: TColor.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    imageUrl: cart[index].image,
                    height: 80,
                    width: 80,
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
                                cart[index].title.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              if (index != 2)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cart[index].subtitle.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 5),
                              index % 2 == 0
                                  ? Text(
                                      "\$${cart[index].price.toString()}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "\$${cart[index].price.toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: TColor.textlineThrough,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          "\$${cart[index].price.toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  final removedItem = cart[index];
                                  cart.removeAt(index);
                                  listKey.currentState!.removeItem(
                                      index,
                                      (context, animation) => ListItemWidget(
                                            cart: removedItem,
                                            animation: animation,
                                            onClicked: () {},
                                          ));

                                  //cart.removeAt(index);
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/delete.svg",
                                  width: 12,
                                  height: 12,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (cart[index].counter >= 1) {
                                          cart[index].counter--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Container(
                                    width: 25,
                                    alignment: Alignment.center,
                                    height: 25,
                                    child: Text(
                                      cart[index].counter.toString(),
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cart[index].counter++;
                                      });
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: TColor.black,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Icon(
                                        Icons.add,
                                        color: TColor.white,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final MyCart cart;
  final Animation<double> animation;
  final VoidCallback onClicked;
  const ListItemWidget(
      {super.key,
      required this.cart,
      required this.animation,
      required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    );
  }
}
