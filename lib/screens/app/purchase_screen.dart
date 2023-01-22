import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../exceptions/api_exception.dart';
import '../../services/api_service.dart';
import '../../utils/shared_prefs.dart';
import '../../widgets/scaffold_snackbar.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final List<String> _productIDS = ['zipremium', 'zipweek'];
  bool _available = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _purchasedIdsFromServer = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  var isLoading = false;

  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      setState(() {
        _purchases.addAll(purchaseDetailsList);
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
    }, onDone: () {
      _subscription!.cancel();
    }, onError: (error) {
      _subscription!.cancel();
    });

    _initialize();

    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

  void _initialize() async {
    print(SharedPrefs().oauth2Storage.getCurrentUser()?.user.uuid);
    _getActiveSubscriptions();
    _available = await _inAppPurchase.isAvailable();

    List<ProductDetails> products = await _getProducts(
      productIds: Set<String>.from(
        _productIDS,
      ),
    );
    setState(() {
      _products = products;
    });
  }

  _getActiveSubscriptions() async {
    try {
      var response = await ApiService().getActiveSubscriptions();
      setState(() {
        _purchasedIdsFromServer = response.purchases.map((e) {
          return e.product_id;
        }).toList();
      });
    } on APIException catch (e) {
      ScaffoldSnackbar(context: context, message: e.message);
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    // log(purchaseDetailsList.last.verificationData.serverVerificationData);
    purchaseDetailsList.reversed
        .forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          setState(() {
            isLoading = true;
          });
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          setState(() {
            isLoading = false;
          });
          //await _verifyPurchase(purchaseDetails);
          // if (!valid) {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
          break;
        case PurchaseStatus.error:
          setState(() {
            isLoading = false;
          });
          await _inAppPurchase.completePurchase(purchaseDetails);

          // _handleError(purchaseDetails.error!);
          break;
        case PurchaseStatus.canceled:
          await _inAppPurchase.completePurchase(purchaseDetails);
          setState(() {
            isLoading = false;
          });
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<List<ProductDetails>> _getProducts(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }

  _restorePurchase() async {
    InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _inAppPurchase
        .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    var vf = await iosPlatformAddition.refreshPurchaseVerificationData();

    try {
      ApiService().restorePurchases(vf!.serverVerificationData);
    } catch (e) {
      print(e);
    }
  }

  _buildProduct({required ProductDetails product}) {
    return Container(
      width: 150,
      child: Card(
        color: Colors.grey[800],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title + ' ' + product.price,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Text(
                product.description,
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _subscribe(product: product);
              },
              child: Text(
                _purchasedIdsFromServer.contains(product.id)
                    ? 'Abonesiniz'
                    : 'Abone Ol',
                style: TextStyle(fontSize: 12),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _purchasedIdsFromServer.contains(product.id)
                      ? Colors.green
                      : Colors.pink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _subscribe({required ProductDetails product}) async {
    var uuid = SharedPrefs().oauth2Storage.getCurrentUser()?.user.uuid;
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product,
      applicationUserName: uuid,
    );
    await _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

// zip.tester@test.com | MyTest123
// m5.ks@icloud.com | Qweqwe11*_
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Abonelikler'),
      ),
      body: _available
          ? scrollView()
          : Center(
              child: Text('The Store Is Not Available'),
            ),
    );
  }

  Widget scrollView() {
    return isLoading != true
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.pink[600],
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Abone Ol',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        'Abone olarak daha fazla içeriğe erişim sağlayabilirsiniz.',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          _restorePurchase();
                        },
                        icon: Icon(Icons.replay_outlined),
                        label: Text('Aboneliklerimi Geri Yükle'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink[400]),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  height: 200,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return _buildProduct(
                          product: _products[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Yükleniyor',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          );
  }
}
