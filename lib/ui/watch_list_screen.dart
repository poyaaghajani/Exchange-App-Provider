import 'dart:async';

import 'package:exchange/models/crypto_models/crypto_data.dart';
import 'package:exchange/network/response_model.dart';
import 'package:exchange/providers/market_view_provider.dart';
import 'package:exchange/ui/ui_helper/decimal_rounder.dart';
import 'package:exchange/ui/ui_helper/shimmer_watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late Timer timer;

  var defaultChoiceIndex = 0;

  var days = '1d';

  @override
  void initState() {
    final marketProvider =
        Provider.of<MarketViewProvider>(context, listen: false);
    marketProvider.getAllCryptoData();

    timer = Timer.periodic(const Duration(seconds: 20),
        (Timer t) => marketProvider.getAllCryptoData());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var primaryColor = Theme.of(context).primaryColor;
    var textTheme = Theme.of(context).textTheme;
    var background = Theme.of(context).scaffoldBackgroundColor;

    final List<String> _choiceList = [
      AppLocalizations.of(context)!.market24,
      AppLocalizations.of(context)!.market7d,
      AppLocalizations.of(context)!.market30d,
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(AppLocalizations.of(context)!.watchList),
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      body: Column(
        children: [
          SizedBox(height: height / 100),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 10,
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
                      defaultChoiceIndex = value ? index : defaultChoiceIndex;

                      switch (index) {
                        case 0:
                          days = '1d';
                          break;
                        case 1:
                          days = '7d';
                          break;
                        case 2:
                          days = '30d';
                          break;
                      }
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<MarketViewProvider>(
                builder: (context, marketViewProvider, child) {
              switch (marketViewProvider.state.status) {
                case Status.LOADING:
                  return const ShimerWatchListScreen();
                case Status.COMPLETED:
                  List<CryptoData>? model =
                      marketViewProvider.dataFuture.data!.cryptoCurrencyList;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemCount: model!.length,
                          itemBuilder: (context, index) {
                            var number = index + 1;
                            var tokenId = model[index].id;

                            // make variabels for 24H , 7D and 30D percentChanges
                            var percent24H =
                                model[index].quotes![0].percentChange24h;

                            var percent7D =
                                model[index].quotes![0].percentChange7d;

                            var percent30D =
                                model[index].quotes![0].percentChange30d;

                            // make variabels for 24H, 7D and 30D volume
                            var volume24H =
                                model[index].quotes![0].percentChange24h;

                            var volume7D =
                                model[index].quotes![0].percentChange7d;

                            var volume30D =
                                model[index].quotes![0].percentChange30d;

                            // get filter color for chart (green or red)
                            MaterialColor filterColor =
                                DecimalRounder.setColorFilter(
                                    model[index].quotes![0].percentChange24h);

                            // get price decimals fix
                            var finalPrice = DecimalRounder.removePriceDecimals(
                                model[index].quotes![0].price);

                            // percent change setup decimals and colors
                            var percentChange =
                                DecimalRounder.removePercentDecimals(
                                    defaultChoiceIndex == 0
                                        ? percent24H
                                        : defaultChoiceIndex == 1
                                            ? percent7D
                                            : percent30D);

                            Color percentColor =
                                DecimalRounder.setPercentChangesColor(
                                    defaultChoiceIndex == 0
                                        ? percent24H
                                        : defaultChoiceIndex == 1
                                            ? percent7D
                                            : percent30D);
                            Icon percentIcon =
                                DecimalRounder.setPercentChangesIcon(
                                    defaultChoiceIndex == 0
                                        ? percent24H
                                        : defaultChoiceIndex == 1
                                            ? percent7D
                                            : percent30D);

                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  height: height * 0.075,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          number.toString(),
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 15),
                                        child: SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              fadeInDuration: const Duration(
                                                  milliseconds: 500),
                                              height: 32,
                                              width: 32,
                                              imageUrl:
                                                  "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  LoadingAnimationWidget
                                                      .inkDrop(
                                                color: Color(0xff4a64fe),
                                                size: 35,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
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
                                              style: textTheme.bodySmall,
                                              overflow: TextOverflow.ellipsis,
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
                                        // flex: 2,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              filterColor, BlendMode.srcATop),
                                          child: SvgPicture.network(
                                            "https://s3.coinmarketcap.com/generated/sparklines/web/$days/2781/$tokenId.svg",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\$$finalPrice",
                                                style: textTheme.bodySmall,
                                              ),
                                              Text(
                                                defaultChoiceIndex == 0
                                                    ? volume24H
                                                        .toString()
                                                        .substring(4)
                                                    : defaultChoiceIndex == 1
                                                        ? volume7D
                                                            .toString()
                                                            .substring(4)
                                                        : volume30D
                                                            .toString()
                                                            .substring(4),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 179, 3, 255)),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  percentIcon,
                                                  Text(
                                                    percentChange + "%",
                                                    style: GoogleFonts.ubuntu(
                                                      color: percentColor,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                case Status.ERROR:
                  return Center(
                    child: Text(marketViewProvider.state.message),
                  );
                default:
                  return const ShimerWatchListScreen();
              }
            }),
          ),
        ],
      ),
    );
  }
}
