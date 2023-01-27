import 'package:exchange/models/crypto_models/crypto_data.dart';
import 'package:exchange/network/response_model.dart';
import 'package:exchange/providers/crypto_data_provider.dart';
import 'package:exchange/ui/ui_helper/decimal_rounder.dart';
import 'package:exchange/ui/ui_helper/home_page_view.dart';
import 'package:exchange/ui/ui_helper/language_switcher.dart';
import 'package:exchange/ui/ui_helper/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageViewController = PageController(initialPage: 0);

  var defaultChoiceIndex = 0;

  @override
  void initState() {
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;
    var textTheme = Theme.of(context).textTheme;
    var background = Theme.of(context).scaffoldBackgroundColor;

    final List<String> _choiceList = [
      AppLocalizations.of(context)!.topMarket,
      AppLocalizations.of(context)!.topGainers,
      AppLocalizations.of(context)!.topLosers,
    ];

    final cryptoProvider = Provider.of<CryptoDataProvider>(context);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const LanguageSwitcher(),
        actions: const [
          ThemeSwitcher(),
        ],
        title: Text(AppLocalizations.of(context)!.exchange),
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height / 70, left: width / 300),
                child: SizedBox(
                  width: width,
                  height: height / 5,
                  child: Stack(
                    children: [
                      HomePageView(
                        controller: _pageViewController,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: ExpandingDotsEffect(
                                dotWidth: 13,
                                dotHeight: 9,
                                activeDotColor: primaryColor),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 20,
                width: width,
                child: Marquee(
                  text: AppLocalizations.of(context)!.description,
                  style: textTheme.bodySmall,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width / 2 - 10, height / 14),
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.buy,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: width / 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width / 2 - 10, height / 14),
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.sell,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 150),
                child: Wrap(
                  spacing: 7,
                  children: List.generate(
                    _choiceList.length,
                    (index) {
                      return ChoiceChip(
                        label: Text(
                          _choiceList[index],
                          style: textTheme.bodyMedium,
                        ),
                        selected: defaultChoiceIndex == index,
                        selectedColor: Colors.grey[600],
                        onSelected: (value) {
                          setState(() {
                            defaultChoiceIndex =
                                value ? index : defaultChoiceIndex;
                            switch (index) {
                              case 0:
                                cryptoProvider.getTopMarketCapData();
                                break;
                              case 1:
                                cryptoProvider.getTopGainersData();
                                break;
                              case 2:
                                cryptoProvider.getTopLosersData();
                                break;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.38,
                width: width,
                child: Consumer<CryptoDataProvider>(
                  builder: (context, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: height / 8,
                          child: Shimmer.fromColors(
                            // ignore: sort_child_properties_last
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, bottom: 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width / 7,
                                              height: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SizedBox(
                                                width: width / 14,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width / 5,
                                              height: 40,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: width / 7,
                                              height: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SizedBox(
                                                width: width / 14,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                              },
                            ),
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                          ),
                        );
                      case Status.COMPLETED:
                        List<CryptoData>? model = cryptoDataProvider
                            .dataFuture.data!.cryptoCurrencyList;
                        return ListView.separated(
                          itemCount: 10,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            var number = index + 1;
                            var tokenId = model![index].id;

                            MaterialColor filterColor =
                                DecimalRounder.setColorFilter(
                              model[index].quotes![0].percentChange24h,
                            );

                            var finalPrice = DecimalRounder.removePriceDecimals(
                                model[index].quotes![0].price);

                            var percentChange =
                                DecimalRounder.removePercentDecimals(
                                    model[index].quotes![0].percentChange24h);

                            Color percentColor =
                                DecimalRounder.setPercentChangesColor(
                                    model[index].quotes![0].percentChange24h);

                            Icon percentIcon =
                                DecimalRounder.setPercentChangesIcon(
                                    model[index].quotes![0].percentChange24h);

                            return SizedBox(
                              height: height * 0.075,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      number.toString(),
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        height: 32,
                                        width: 32,
                                        imageUrl:
                                            'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model[index].name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodySmall,
                                        ),
                                        Text(
                                          model[index].symbol!,
                                          style: textTheme.labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          filterColor, BlendMode.srcATop),
                                      child: SvgPicture.network(
                                          'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('\$$finalPrice',
                                              style: textTheme.bodySmall),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                percentChange + '%',
                                                style: GoogleFonts.ubuntu(
                                                    color: percentColor,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      case Status.ERROR:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cryptoDataProvider.state.message,
                              style: textTheme.bodySmall,
                            ),
                          ],
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
