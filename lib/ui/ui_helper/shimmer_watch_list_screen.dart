import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWatchListScreen extends StatelessWidget {
  const ShimerWatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(Icons.add),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: 25,
                                      height: 15,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 70,
                              height: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: 25,
                                      height: 15,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
