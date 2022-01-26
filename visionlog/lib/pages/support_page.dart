import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../widgets/consumable_store.dart';

const bool _kAutoConsume = true;
const String _teaDonationId = 'donation';
const String _lunchDonationId = 'lunch_donation';
const String _dinnerDonationId = 'dinner_donation';
const List<String> _kProductIds = <String>[
  _teaDonationId,
  _lunchDonationId,
  _dinnerDonationId
];

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  final Map _productStyling = {
    _teaDonationId: {
      'icon': const Icon(Icons.coffee),
      'colour': const Color(0xff6ab368),
    },
    _lunchDonationId: {
      'icon': const Icon(Icons.lunch_dining),
      'colour': const Color(0xff68a0b3),
    },
    _dinnerDonationId: {
      'icon': const Icon(Icons.dinner_dining),
      'colour': const Color(0xff7768b3),
    },
  };

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildProductList(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const [
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Me'),
      ),
      body: Stack(
        children: stack,
      ),
    );
  }

  Widget _buildProductList() {
    if (_loading) {
      return const Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...'))));
    }
    if (!_isAvailable) {
      return const Card();
    }
    List<dynamic> _buildProducts = <dynamic>[];

    // Display error if products ids are not found
    if (_notFoundIds.isNotEmpty) {
      _buildProducts.add(Card(
        child: ListTile(
            title: Text('Can\'t find products: [${_notFoundIds.join(", ")}]',
                style: TextStyle(color: ThemeData.dark().errorColor)),
            subtitle: const Text('Error: Contact sethcohen.dev@gmail.com')),
      ));
    }
    _sortProducts();
    _buildProducts.add(Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _products.map(
          (ProductDetails productDetails) {
            return TextButton.icon(
              icon: _productStyling[productDetails.id]['icon'],
              label: Text(
                  '${productDetails.title.substring(0, productDetails.title.indexOf('(Vision Log'))}\n${productDetails.price}'),
              style: TextButton.styleFrom(
                backgroundColor: _productStyling[productDetails.id]['colour'],
                primary: Colors.white,
              ),
              onPressed: () {
                late PurchaseParam purchaseParam;

                if (Platform.isAndroid) {
                  purchaseParam = GooglePlayPurchaseParam(
                      productDetails: productDetails,
                      applicationUserName: null,
                      changeSubscriptionParam: null);
                } else {
                  purchaseParam = PurchaseParam(
                    productDetails: productDetails,
                    applicationUserName: null,
                  );
                }

                _inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
              },
            );
          },
        ).toList()));

    return Column(children: <Widget>[
      const Divider(
        height: 8,
      ),
      const Text(
        'Thank you for your purchase!',
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const Text('I really do appreciate it. 🙂'),
      const Divider(
        height: 16,
      ),
      ..._buildProducts
    ]);
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _teaDonationId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    debugPrint('Purchase failed');
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      var priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
          ),
        ));
      }
    }
  }

  void _sortProducts() {
    _products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
  }
}