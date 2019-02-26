package com.persenlee.storerate;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.Intent;
import android.net.Uri;
import android.content.Context;

/**
 * StoreRatePlugin
 */
public class StoreRatePlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "plugin.persenlee.com/rate");
        channel.setMethodCallHandler(new StoreRatePlugin(registrar));
    }

    private final Registrar registrar;

    private StoreRatePlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("rate")) {
            try {
                String appId = call.argument("appId");
                if(appId == null || appId.length() == 0) {
                  appId = registrar.context().getPackageName();
                }
                Uri uri = Uri.parse("market://details?id=" + appId);
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                if (registrar.activity() == null) {
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    registrar.context().startActivity(intent);
                } else {
                    registrar.activity().startActivity(intent);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            result.notImplemented();
        }
    }
}
