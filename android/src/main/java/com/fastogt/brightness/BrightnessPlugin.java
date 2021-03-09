package com.fastogt.brightness;

import android.app.Activity;
import android.content.res.Resources;
import android.provider.Settings;
import android.view.WindowManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;

public class BrightnessPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {

    private Activity _activity;

    public BrightnessPlugin() { }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        final MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), "github.com/fastogt/brightness");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this._activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this._activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        this._activity = null;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "brightness":
                result.success(getBrightness());
                break;
            case "setBrightness":
                double brightness = call.argument("brightness");
                WindowManager.LayoutParams layoutParams = _activity.getWindow().getAttributes();
                layoutParams.screenBrightness = (float) brightness;
                _activity.getWindow().setAttributes(layoutParams);
                result.success(null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private float getBrightness() {
        float result = _activity.getWindow().getAttributes().screenBrightness;
        if (result < 0) { // the application is using the system brightness
            try {
                result = Settings.System.getInt(_activity.getApplicationContext().getContentResolver(), Settings.System.SCREEN_BRIGHTNESS) / (float) getBrightnessMax();
            } catch (Settings.SettingNotFoundException e) {
                result = 1.0f;
                e.printStackTrace();
            }
        }
        return result;
    }

    private int getBrightnessMax() {
        try {
            Resources system = Resources.getSystem();
            int resId = system.getIdentifier("config_screenBrightnessSettingMaximum", "integer", "android");
            if (resId != 0) {
                return system.getInteger(resId);
            }
        } catch (Exception ignore) {
        }
        return 255;
    }
}