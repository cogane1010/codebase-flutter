package com.brg.golf.brg_management

import android.view.WindowManager.LayoutParams
import android.widget.Toast
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONArray
//import vn.com.seabank.payment.base.SBPay
//import vn.com.seabank.payment.callback.GetFundsCallback
//import vn.com.seabank.payment.callback.SBCallback
//import vn.com.seabank.payment.callback.SBPayCallback
//import vn.com.seabank.payment.enum.CardType
//import vn.com.seabank.payment.enum.Language
//import vn.com.seabank.payment.model.SBFund
//import vn.com.seabank.payment.model.SBPaidInfo
//import vn.com.seabank.payment.model.SBPayError
//import vn.com.seabank.payment.network.SBPayInfo
//import vn.com.seabank.payment.network.SBPaySmsOtpInfo

class MainActivity : FlutterFragmentActivity() {
    
    private lateinit var channel: MethodChannel
    var partnerUserId: String? = ""
    val gson = Gson()
    var mResult: MethodChannel.Result? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
       

    }
}