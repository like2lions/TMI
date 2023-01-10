//
//  Last.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

// MARK: -Last
/// OnBoardingView의 마지막 탭 뷰
struct Last: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("당신만의 TMI를 완성해보세요")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity)
                LottieManager(jsonName: "last_lottie")
                    .offset(y: -100)
            }
            .offset(y: 70)
            //홈뷰로 넘어가는 버튼
            Button(action: {}) {
                Text("TMI 시작하기")
                    .foregroundColor(.white)
                    .bold()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width: 200, height: 50)
                    }
            }
            .offset(x: 130, y: -170)
        }
        .padding(.horizontal, 25)
    }
}

struct Last_Previews: PreviewProvider {
    static var previews: some View {
        Last()
    }
}
