//
//  PaymentService.swift
//  Runner
//
//  Created by ChungTV on 05/08/2022.
//

import UIKit
import Flutter
import NVActivityIndicatorView
import SwiftyRSA
import CryptoSwift
import SBPaySDK
import Foundation



class PaymentService: NSObject {
    
   
    
    class func initSDK(_ context: UIViewController, arguments: [String: String]?, result: @escaping FlutterResult) {
        var langType = LangType.vi
        if arguments?["currentLanguage"] == "vi"{
            langType = LangType.vi
        }else{
            langType = LangType.en
        }
        
        SBPay.sharedInstance.initSDK(
                  viewController: context,               // viewController tích hợp SDK
                  lang: langType,                      // sử dụng enum class LangType để truyền vào ngôn ngữ là vi/en.
                  partnerCode:  "BRG",
                  partnerServiceId:"GOLF",
                  partnerUserId: arguments?["getPartnerUserId"] ?? "")    // R - ID user của hệ thống partner
        { isSuccess, errorMess, errorCode in
                    if isSuccess {
                        result("Init SDK Payment Success")
                    } else {
                        result(errorCode)
                    }
                    
                }
    }
    
    class func linkCard(_ context: UIViewController, arguments: [String: String]?, result: @escaping FlutterResult) {
        
        
        SBPay.sharedInstance.addFund(viewController: context, cardType: CardType.all, isAccountVnd: true)
       // SBPay.sharedInstance.addFund(viewController: context, cardType: CardType.all)
    }
    
    class func unlinkCard(arguments: [String: String]?, result: @escaping FlutterResult) {
        let linkCardAccId = arguments?["link_card_acc_id"] ?? ""
        SBPay.sharedInstance.removeFund(linkCardAcctId: linkCardAccId) { isSuccess, errorMess, errorCode in
            if isSuccess {
                    result("Unlink Card Success")
                } else {
                    let savedData: [String: Any] = ["message": errorMess,"errorCode":errorCode]
                    // Convert the JSON object to a string
                    let jsonString = try? JSONSerialization.data(withJSONObject: savedData, options: [])
                    let stringRepresentation = String(data: jsonString!, encoding: .utf8)
                    
                    result(stringRepresentation);                }
            }
        }
    
    
    class func sendSmsOtp(arguments: [String: String]?, result: @escaping FlutterResult) {
        let ccy = arguments?["ccy"] ?? ""
        let linkCardAccId = arguments?["link_card_acc_id"] ?? ""
        let amount = arguments?["amount"] ?? ""
        let partnerBranch = arguments?["partner_branch"] ?? ""
        let customerId = arguments?["customer_id"] ?? ""



        SBPay.sharedInstance.sendSmsOtp(linkCardAcctId: linkCardAccId, amount: amount, partnerBranch: partnerBranch, customerId: customerId, ccy: ccy) { isSuccess,  errorMess, errorCode in

            if isSuccess {
                result("Send Otp Success")
            } else {
                
                let savedData: [String: Any] = ["message": errorMess,"errorCode":errorCode]
                // Convert the JSON object to a string
                let jsonString = try? JSONSerialization.data(withJSONObject: savedData, options: [])
                let stringRepresentation = String(data: jsonString!, encoding: .utf8)
                
                result(stringRepresentation);
            }
        }
    }
    
    class func getCardList(arguments: [String: String]?, result: @escaping FlutterResult) {
        SBPay.sharedInstance.getListFund() { isSuccess, listFund, error in
            if isSuccess {
                if listFund==nil{
                    result("")
                }else{
                    var ListFeeString = ""
                    for item in listFund! {
                    if !ListFeeString.isEmpty { ListFeeString += "," }
                            ListFeeString += (item.toDictionary() as Dictionary).json
                           }
                    
                   let messageBody =  String(format: "{\"data\": [%@]}", ListFeeString)
                result(messageBody)
                }
            } else {
                result("")
            }
            }
        }
    
    class func servicePayment(arguments: [String: String]?, result: @escaping FlutterResult) {
        let payInfo = SBPayInfo(linkCardAcctId: arguments?["link_card_acc_id"],
                                amount: arguments?["amount"],
                                traceId: arguments?["trace_id"],
                                partnerBranch: arguments?["partner_branch"],
                                otp: arguments?["otp"],
                                transDesc: arguments?["trans_desc"],
                                transDate: arguments?["trans_date"],ccy: arguments?["ccy"],refundAmount: "")

        
        SBPay.sharedInstance.pay(payInfo: payInfo) { isSuccess, transactionNO,  errorMess, errorCode in
            if isSuccess {
                //let jsonData = (payInfo.toDictionary() as Dictionary).json
                result(transactionNO)
            } else {
                let savedData: [String: Any] = ["message": errorMess,"errorCode":errorCode]
                // Convert the JSON object to a string
                let jsonString = try? JSONSerialization.data(withJSONObject: savedData, options: [])
                let stringRepresentation = String(data: jsonString!, encoding: .utf8)
                
                result(stringRepresentation);
                
            }
        }
    }
    
    class func cancelPayment(arguments: [String: String]?, result: @escaping FlutterResult) {


        let ccy = arguments?["ccy"] ?? ""
        let linkCardAccId = arguments?["link_card_acc_id"] ?? ""
        let partnerBranch = arguments?["partner_branch"] ?? ""
        let traceId =  arguments?["trace_id"] ?? ""
        let amountt = arguments?["refund_amount"] ?? ""




        let payinfo = SBPaidInfo(linkCardAcctId: linkCardAccId, traceId: traceId, otp: "", partnerBranch: partnerBranch, ccy: ccy, refundAmount: amountt)

        SBPay.sharedInstance.cancelTransaction(payInfo: payinfo) { isSuccess, transactionNO, errorMess, errorCode in
            if isSuccess {
                result(transactionNO)

            } else {
                let savedData: [String: Any] = ["message": errorMess,"errorCode":errorCode]
                // Convert the JSON object to a string
                let jsonString = try? JSONSerialization.data(withJSONObject: savedData, options: [])
                let stringRepresentation = String(data: jsonString!, encoding: .utf8)
                
                result(stringRepresentation);
            }
        }
        }
    }


