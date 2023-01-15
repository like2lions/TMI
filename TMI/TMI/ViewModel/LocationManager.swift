//
//  LocationManager.swift
//  TMI
//
//  Created by 김응관 on 2023/01/15.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var completionHandler: ((CLLocationCoordinate2D) -> (Void))?
    
    override init() {
        super.init()
        manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 정보 승인 요청
        manager.requestWhenInUseAuthorization()
    }
    
    //위치 정보 요청 - 정보 요청이 성공하면 실행될 completionHandler를 등록
    func requestLocation(completion: @escaping ((CLLocationCoordinate2D) -> (Void))) {
        completionHandler = completion
        manager.requestLocation()
    }
    
    //위치 정보가 업데이트 될 때 호출되는 delegate 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        //requestLocation 에서 등록한 completion handler를 통해 위치 정보를 전달
        if let completion = self.completionHandler {
            completion(location.coordinate)
        }
//        //위치 정보 업데이트 중단
//        manager.stopUpdatingLocation()
    }
}
