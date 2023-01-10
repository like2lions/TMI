//
//  OnBoardingTab.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

struct OnBoardingTab: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            First()
            Second()
            Third()
            Last()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            customPageIndicator()
        }
    }
    
    func customPageIndicator() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .white
    }
}

struct OnBoardingTab_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTab(isFirstLaunching: .constant(true))
    }
}
