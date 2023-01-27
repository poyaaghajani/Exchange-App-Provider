import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange/models/crypto_models/all_crypto_model.dart';
import 'package:exchange/network/response_model.dart';
import 'package:exchange/providers/market_view_provider.dart';
import 'package:exchange/ui/ui_helper/decimal_rounder.dart';
import 'package:exchange/ui/ui_helper/shimmer_market_page.dart';
import 'package:exchange/ui/ui_helper/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/crypto_models/crypto_data.dart';

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({Key? key}) : super(key: key);

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    final marketProvider =
        Provider.of<MarketViewProvider>(context, listen: false);
    marketProvider.getAllCryptoData();

    timer = Timer.periodic(const Duration(seconds: 20),
        (Timer t) => marketProvider.getAllCryptoData());
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
    var borderColor = Theme.of(context).secondaryHeaderColor;
    var background = Theme.of(context).scaffoldBackgroundColor;
    var searchIcon = Theme.of(context).cardColor;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(AppLocalizations.of(context)!.marketView),
          titleTextStyle: textTheme.titleLarge),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Consumer<MarketViewProvider>(
                  builder: (context, marketViewProvider, child) {
                switch (marketViewProvider.state.status) {
                  case Status.LOADING:
                    return const ShimerMarketPage();
                  case Status.COMPLETED:
                    List<CryptoData>? model =
                        marketViewProvider.dataFuture.data!.cryptoCurrencyList;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 15),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                'assets/images/search.png',
                                color: searchIcon,
                              ),
                              filled: true,
                              fillColor: borderColor,
                              hintText: 'Search...',
                              hintStyle: textTheme.bodySmall,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            itemCount: model!.length,
                            itemBuilder: (context, index) {
                              var number = index + 1;
                              var tokenId = model[index].id;

                              // get filter color for chart (green or red)
                              MaterialColor filterColor =
                                  DecimalRounder.setColorFilter(
                                      model[index].quotes![0].percentChange24h);

                              // get price decimals fix
                              var finalPrice =
                                  DecimalRounder.removePriceDecimals(
                                      model[index].quotes![0].price);

                              // percent change setup decimals and colors
                              var percentChange =
                                  DecimalRounder.removePercentDecimals(
                                      model[index].quotes![0].percentChange24h);

                              Color percentColor =
                                  DecimalRounder.setPercentChangesColor(
                                      model[index].quotes![0].percentChange24h);
                              Icon percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      model[index].quotes![0].percentChange24h);

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => TokenDetailPage(cryptoData: model[index])));
                                  },
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
                                                    Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade400,
                                                  highlightColor: Colors.white,
                                                  child: const SizedBox(
                                                    width: 32,
                                                    height: 32,
                                                  ),
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
                                                    filterColor,
                                                    BlendMode.srcATop),
                                                child: SvgPicture.network(
                                                  "https://s3.coinmarketcap.com/generated/sparklines/web/30d/2781/$tokenId.svg",
                                                ))),
                                        // Spacer(),
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
                    return const ShimerMarketPage();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
