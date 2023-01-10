//
//  Third.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

// MARK: -Third
/// OnBoardingView의 세번째 탭 뷰
struct Third: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("사진, 문서 등등")
                    .font(.title)
                    .bold()
                Spacer().frame(height: 15)
                Text("다양한 파일정리 가능")
                    .font(.title)
                    .bold()
                LottieManager(jsonName: "third_lottie")
                    .offset(y: -100)
            }
            .offset(y: 70)
        }
        .padding(.horizontal, 25)
    }
}

struct Third_Previews: PreviewProvider {
    static var previews: some View {
        Third()
    }
}
