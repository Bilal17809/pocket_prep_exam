import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import '../core/local_storage/storage_helper.dart';
import '/ad_manager/ad_manager.dart';

class PurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final RemoveAds removeAdsController = Get.put(RemoveAds());

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  bool _purchasePending = false;
  bool get purchasePending => _purchasePending;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  String? _queryProductError;
  String? get queryProductError => _queryProductError;

  final bool _kAutoConsume = Platform.isIOS || false;

  final List<String> _kSubscriptionIds = const [
    'com.professionalexam.yearly',
    'com.professionalexam.quarterly',
    'com.professionalexam.monthly',
  ];

  final List<String> _kNonSubscriptionIds = const [
    'consumable',
    'upgrade',
  ];

  Set<String> get _allProductIds => {
    ..._kNonSubscriptionIds,
    ..._kSubscriptionIds,
  }.toSet();


  Future<void> init([void Function(void Function())? setState]) async {
    await _checkInternetConnection();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
          (details) => _listenToPurchaseUpdated(details, setState!),
      onDone: () => _subscription.cancel(),
      onError: (Object error) {
        debugPrint('Error in purchase stream: $error');
        if (Navigator.of(Get.context!).canPop()) {
          Navigator.of(Get.context!).pop();
        }
        setState!(() => _purchasePending = false);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Purchase stream error: ${error.toString()}')),
        );
      },
    );

    await _checkInitialPurchases();

    await initStoreInfo(setState!);
  }

  void dispose() {
    _subscription.cancel();
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.wifi)) {
      if (!Get.context!.mounted) return;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(const SnackBar(content: Text("No Internet Available")));
    }
  }

  Future<void> initStoreInfo(void Function(void Function()) setState) async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      setState(() {
        _isAvailable = false;
        _products = [];
        _queryProductError = null;
        _purchasePending = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_allProductIds);

    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = available;
      });
      return;
    }

    setState(() {
      _isAvailable = available;
      _products = productDetailResponse.productDetails;
    });
  }

  Future<void> buyProduct(
      ProductDetails product,
      PurchaseDetails? purchase,
      BuildContext context,
      ) async {
    // 1. Show the INITIAL custom loader dialog (Pre-native call)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Connecting to store...'),
          ],
        ),
      ),
    );

    try {
      final purchaseParam = GooglePlayPurchaseParam(
        productDetails: product,
        changeSubscriptionParam:
        purchase != null && purchase is GooglePlayPurchaseDetails
            ? ChangeSubscriptionParam(oldPurchaseDetails: purchase)
            : null,
      );

      // 2. DISMISS the INITIAL loader
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // 3. Re-show the loader to block the screen while the transaction processes (POST-native call) 👈 UNCOMMENT THIS FIX!
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (_) => const AlertDialog(
      //     content: Row(
      //       children: [
      //         CircularProgressIndicator(),
      //         SizedBox(width: 20),
      //         Text('Processing purchase...'),
      //       ],
      //     ),
      //   ),
      // );

      // 4. Initiate the native purchase flow (User interacts with Google Dialog)
      if (product.id == 'consumable') {
        // DO NOT use await here.
        _inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam,
          autoConsume: _kAutoConsume,
        );
      } else {
        // DO NOT use await here.
        _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      }

      // The screen is now blocked by the "Processing purchase..." dialog.

    } catch (e) {
      debugPrint('Purchase initiation error: $e');

      // In case of an immediate catch error, close the loader that was just shown.
      if (Navigator.of(Get.context!).canPop()) {
        Navigator.of(Get.context!).pop();
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to initiate purchase: ${e.toString()}')),
      );
    }
  }
  // Future<void> buyProduct(
  //     ProductDetails product,
  //     PurchaseDetails? purchase,
  //     BuildContext context,
  //     ) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => const AlertDialog(
  //       content: Row(
  //         children: [
  //           CircularProgressIndicator(),
  //           SizedBox(width: 20),
  //           Text('Connecting to store...'),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   try {
  //     final purchaseParam = GooglePlayPurchaseParam(
  //       productDetails: product,
  //       changeSubscriptionParam:
  //       purchase != null && purchase is GooglePlayPurchaseDetails
  //           ? ChangeSubscriptionParam(oldPurchaseDetails: purchase)
  //           : null,
  //     );
  //
  //     if (product.id == 'consumable') {
  //       await _inAppPurchase.buyConsumable(
  //         purchaseParam: purchaseParam,
  //         autoConsume: _kAutoConsume,
  //       );
  //     } else {
  //       await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  //     }
  //   } catch (e) {
  //     debugPrint('Purchase initiation error: $e');
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       SnackBar(content: Text('Failed to initiate purchase: ${e.toString()}')),
  //     );
  //     if (Navigator.of(Get.context!).canPop()) {
  //       Navigator.of(Get.context!).pop();
  //     }
  //   }
  // }

  Future<void> _checkInitialPurchases() async {
    debugPrint('Checking existing purchases via silent restore...');
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint('Error during silent purchase check: $e');
      await StorageService.clearSubscriptionState();
      removeAdsController.isSubscribedGet(false);
    }
  }


  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> detailsList,
      void Function(void Function()) setState,
      ) async {
    bool foundActiveSubscription = false;
    for (var details in detailsList) {
      if (details.status == PurchaseStatus.pending) {
        setState(() => _purchasePending = true);
      } else if (details.status == PurchaseStatus.error) {
        setState(() => _purchasePending = false);

        // NEW (Use GetX for safer dialog dismissal):
        if (Get.isDialogOpen ?? false) { // Check if ANY dialog is open
          Get.back(); // Safely dismisses the topmost dialog ('Processing purchase...')
        }
        // if (Navigator.of(Get.context!).canPop()) {
        //   Navigator.of(Get.context!).pop();
        // }
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Purchase failed: ${details.error?.message ?? "Unknown error"}',
            ),
          ),
        );
      } else if (details.status == PurchaseStatus.purchased ||
          details.status == PurchaseStatus.restored) {

        if (_kSubscriptionIds.contains(details.productID)) {
          foundActiveSubscription = true;

          setState(() => _purchasePending = false);

          if (Navigator.of(Get.context!).canPop()) {
            Navigator.of(Get.context!).pop();
          }
          await StorageService.saveGeneralSubscriptionStatus(true);
          await StorageService.saveSubscriptionProductId(details.productID);
          removeAdsController.isSubscribedGet(true);
          if (details.status == PurchaseStatus.purchased) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(content: Text('Subscription purchased successfully!')),
            );
          } else {
            debugPrint('Subscription restored: ${details.productID}');
          }
          if (details.pendingCompletePurchase) {
            await _inAppPurchase.completePurchase(details);
          }
        }
      }
    }

    if (detailsList.isNotEmpty && detailsList.every((d) => d.status == PurchaseStatus.restored) && !foundActiveSubscription) {
      await StorageService.clearSubscriptionState();
      removeAdsController.isSubscribedGet(false);
      debugPrint('Restore successful, but no active subscription found.');
    }
  }

  Future<void> restorePurchases(
      BuildContext context,
      void Function(void Function()) setState,
      ) async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(const SnackBar(content: Text('Store is not available!')));
      return;
    }
    setState(() => _purchasePending = true);
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Restoring purchases...'),
          ],
        ),
      ),
    );
    try {
      await _inAppPurchase.restorePurchases();
      Timer(const Duration(seconds: 15), () {
        if (_purchasePending) {
          setState(() => _purchasePending = false);
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Restore timed out or no purchases found.'),
            ),
          );
        }
      });
    } catch (e) {
      setState(() => _purchasePending = false);
      if (Navigator.of(Get.context!).canPop()) {
        Navigator.of(Get.context!).pop();
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('An error occurred during restore: $e')),
      );
    }
  }
}
