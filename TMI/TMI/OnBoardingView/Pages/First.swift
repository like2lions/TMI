//
//  OnBoarding.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

// MARK: -First
/// OnBoardingView의 첫번째 탭 뷰

struct First: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("내 손안의")
                    .font(.largeTitle)
                    .bold()
                Spacer().frame(height: 15)
                Text("작은 터미널")
                    .font(.largeTitle)
                    .bold()
                Spacer().frame(height: 150)
                Image("terminal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -15, y: -50)
            }
            .offset(y: -40)
        }
        .padding(.horizontal, 25)
    }
}

struct First_Previews: PreviewProvider {
    static var previews: some View {
        First()
    }
}
