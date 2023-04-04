//
//  ViewController.swift
//  MyMap
//
//  Created by keigo.shiibashi on 2022/10/16.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Text Fieldのdelegate通知先を設定
        inputText.delegate = self
       }
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispmap: MKMapView!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        //入力された文字を取り出す(2)
        if let searchkey = textField.text{
            //入力された文字をデバックエリアに表示(3)
            print(searchkey)
            
            //CLGeocoderインスタンスを取得
            let geocoder = CLGeocoder()
            
            //入力された文字から位置情報を取得(6)
            geocoder.geocodeAddressString(searchkey , completionHandler:{ (placemarks,error) in
                
                //　位置情報が存在する場合には、unwrapPlacemarksに取り出す(7)
                if let unwrapPlacemarks = placemarks {
                    //1件目の情報を取り出す。
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        //位置情報を取り出す(9)
                        if let location = firstPlacemark.location {
                            
                            //位置情報から緯度経度をtargetCoordinateに取り出す
                            let targetCoordinate = location.coordinate
                            
                            //緯度経度をデバックエリアに表示(11)
                            print(targetCoordinate)
                            
                            //MKPointAnnotationインスタンスを取得し、ピンを生成(12)
                            let pin = MKPointAnnotation()
                            
                            //ピンの置く場所に緯度経度を設定(13)
                            pin.coordinate = targetCoordinate
                            
                            //ピンのタイトルを設定(14)
                            pin.title = searchkey
                            
                            //ピンを地図に置く(15)
                            self.dispmap.addAnnotation(pin)
                            
                            //緯度経度を中心にして半径500mの範囲を表示(16)
                            self.dispmap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters:500.0, longitudinalMeters: 500.0)
                            
                            
                        
                    }
                }
            }
        })
    }
        //デフォルト動作を行うので、trueで返す
        return true
}
    
}
