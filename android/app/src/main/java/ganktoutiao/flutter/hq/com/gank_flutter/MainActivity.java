package ganktoutiao.flutter.hq.com.gank_flutter;

import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private final static String FLUTTER_LOG_CHANNEL = "android_log";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    if(Build.VERSION.SDK_INT>= Build.VERSION_CODES.LOLLIPOP) {
      //API>21,设置状态栏颜色透明
      getWindow().setStatusBarColor(0);
    }

    GeneratedPluginRegistrant.registerWith(this);
    registerLogger(getFlutterView());
  }

  public static void registerLogger(BinaryMessenger messenger) {
    new MethodChannel(messenger, FLUTTER_LOG_CHANNEL).setMethodCallHandler((methodCall, result) -> {
      String tag = methodCall.argument("tag");
      String msg = methodCall.argument("msg");
      switch (methodCall.method) {
        case "logV":
          Log.v(tag, msg);
          break;
        case "logD":
          Log.d(tag, msg);
          break;
        case "logI":
          Log.i(tag, msg);
          break;
        case "logW":
          Log.w(tag, msg);
          break;
        case "logE":
          Log.e(tag, msg);
          break;
        default:
          Log.d(tag, msg);
          break;
      }
    });
  }
}
