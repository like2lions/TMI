//
//  OnBoarding.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI

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
                ZStack {
                        Image("terminal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(x: -15, y: -50)
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

struct First_Previews: PreviewProvider {
    static var previews: some View {
        First()
    }
}
