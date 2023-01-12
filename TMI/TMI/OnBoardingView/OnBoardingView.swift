//
//  OnBoardingView.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

// MARK: - OnBoardingView

/// OnBoardingView가 시작되는 뷰
/// 앱 설치 후 최초만 실행되도록 처리해주고, 본격적인 OnBoardingView의 시작을 알림

struct OnBoardingView: View {
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수이다
    // @AppStorage에 저장되어 앱 종료 후에도 유지되도록 함
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        ContentView()
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnBoardingTab(isFirstLaunching: $isFirstLaunching)
            }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
