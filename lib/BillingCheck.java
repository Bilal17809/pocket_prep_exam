package com.orangeannoe.englishdictionary.billing;


import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.android.billingclient.api.AcknowledgePurchaseParams;
import com.android.billingclient.api.AcknowledgePurchaseResponseListener;
import com.android.billingclient.api.BillingClient;
import com.android.billingclient.api.BillingClientStateListener;
import com.android.billingclient.api.BillingResult;
import com.android.billingclient.api.Purchase;
import com.orangeannoe.englishdictionary.helper.Constants;
import com.orangeannoe.englishdictionary.helper.SharedPref;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

import com.android.billingclient.api.QueryPurchasesParams;


import com.android.billingclient.api.PendingPurchasesParams;


import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class BillingCheck {
    Context mContext;
    private BillingClient mBillingClient;

    public BillingCheck(Context mContext) {
        this.mContext = mContext;

        PendingPurchasesParams pendingParams = PendingPurchasesParams.newBuilder()
                .enableOneTimeProducts()
                .build();

        mBillingClient = BillingClient.newBuilder(mContext)
                .setListener((billingResult, list) -> { })
                .enablePendingPurchases(pendingParams)
                .build();

        mBillingClient.startConnection(new BillingClientStateListener() {
            @Override
            public void onBillingServiceDisconnected() {
                Log.e("BillingCheck", "Billing service disconnected");
            }

            @Override
            public void onBillingSetupFinished(@NonNull @NotNull BillingResult billingResult) {
                if (billingResult.getResponseCode() == BillingClient.BillingResponseCode.OK) {
                    QueryPurchasesParams subsParams = QueryPurchasesParams.newBuilder()
                            .setProductType(BillingClient.ProductType.SUBS)
                            .build();

                    mBillingClient.queryPurchasesAsync(subsParams, (billingResult1, list) -> {
                        if (list != null && list.size() > 0) {
                            Log.e("querysubPurchases", list.size() + "");
                            SharedPref.getInstance(mContext).savePref("removeads", true);
                            handlePurchasesSub(list);
                        } else {
                            SharedPref.getInstance(mContext).savePref("removeads", false);

                            QueryPurchasesParams inAppParams = QueryPurchasesParams.newBuilder()
                                    .setProductType(BillingClient.ProductType.INAPP)
                                    .build();

                            mBillingClient.queryPurchasesAsync(inAppParams, (billingResult11, list1) -> {
                                if (list1 != null && list1.size() > 0) {
                                    Log.e("queryPurchases", list1.size() + "");
                                    handlePurchases(list1);
                                } else {
                                    SharedPref.getInstance(mContext).savePref("removeads", false);
                                }
                            });
                        }
                    });
                }
            }
        });
    }

    AcknowledgePurchaseResponseListener ackPurchase = billingResult -> {
        if (billingResult.getResponseCode() == BillingClient.BillingResponseCode.OK) {
            SharedPref.getInstance(mContext).savePref("removeads", true);
        }
    };

    void handlePurchasesSub(List<Purchase> purchases) {
    for (Purchase purchase : purchases) {
            int state = purchase.getPurchaseState();
            boolean isAutoRenewing = purchase.isAutoRenewing();

            if (state == Purchase.PurchaseState.PURCHASED && isAutoRenewing) {
                SharedPref.getInstance(mContext).savePref("removeads", true);
            } else if (state == Purchase.PurchaseState.PENDING) {
                SharedPref.getInstance(mContext).savePref("removeads", false);
                Toast.makeText(mContext, "Subscription is pending. Please complete the payment.", Toast.LENGTH_LONG).show();
            } else {
                SharedPref.getInstance(mContext).savePref("removeads", false);
            }

            if (state == Purchase.PurchaseState.PURCHASED && !purchase.isAcknowledged()) {
                AcknowledgePurchaseParams acknowledgePurchaseParams =
                        AcknowledgePurchaseParams.newBuilder()
                                .setPurchaseToken(purchase.getPurchaseToken())
                                .build();
                mBillingClient.acknowledgePurchase(acknowledgePurchaseParams, ackPurchase);
            }
        }

        if (mBillingClient.isReady()) {
            mBillingClient.endConnection();
        }









    }

    void handlePurchases(List<Purchase> purchases) {
        for (Purchase purchase : purchases) {
            ArrayList<String> sku = purchase.getSkus();
            for (int i = 0; i < sku.size(); i++) {
                if (Constants.ITEM_SKU_ADREMOVAL.equals(sku.get(i)) && purchase.getPurchaseState() ==
                        Purchase.PurchaseState.PURCHASED) {

                    if (!purchase.isAcknowledged()) {
                        Log.e("queryPurchases_ac", "acknowledged ");
                        AcknowledgePurchaseParams acknowledgePurchaseParams =
                                AcknowledgePurchaseParams.newBuilder()
                                        .setPurchaseToken(purchase.getPurchaseToken())
                                        .build();
                        mBillingClient.acknowledgePurchase(acknowledgePurchaseParams, ackPurchase);
                    } else {
                        Log.e("queryPurchases_ac", "acknowledged already");
                        SharedPref.getInstance(mContext).savePref("removeads", true);
                    }
                } else if (Constants.ITEM_SKU_ADREMOVAL.equals(sku.get(i)) && purchase.getPurchaseState() ==
                        Purchase.PurchaseState.PENDING) {
                    SharedPref.getInstance(mContext).savePref("removeads", false);
                    Toast.makeText(mContext,
                            "Purchase is Pending. Please complete Transaction", Toast.LENGTH_SHORT).show();
                } else if (Constants.ITEM_SKU_ADREMOVAL.equals(sku.get(i)) && purchase.getPurchaseState()
                        == Purchase.PurchaseState.UNSPECIFIED_STATE) {
                    SharedPref.getInstance(mContext).savePref("removeads", false);
                }
            }
        }

        if (mBillingClient.isReady()) {
            mBillingClient.endConnection();
        }
    }
}
