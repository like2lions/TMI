//
//  Second.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

// MARK: -Second
/// OnBoardingView의 두번째 탭 뷰
struct Second: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("간단한 명령어로 즐기는")
                    .font(.title)
                    .bold()
                Spacer().frame(height: 15)
                Text("손쉬운 메모")
                    .font(.title)
                    .bold()
                LottieManager(jsonName: "second_rottie")
            }
            .offset(y: 70)
        }
        .padding(.horizontal, 25)
    }
}

struct Second_Previews: PreviewProvider {
    static var previews: some View {
        Second()
    }
}
