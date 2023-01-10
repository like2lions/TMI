//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
                
            terminalBar()

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct terminalBar: View {
    var body: some View {
        HStack {
            Text("안녕하세요")
                .frame(height: 20.5)
                .padding(.horizontal,10)
                .foregroundColor(.white)
                .background(.black)
            Image("bar1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading, -10)
            Text("오늘 해야")
                .frame(width: .infinity ,height: 20.5)
                .foregroundColor(.white)
                .padding(.horizontal,10)
                .background(Color("barcolor"))
                .padding(.leading, -8)
            Rectangle()
                .rotationEffect(.init(degrees: 45))
                .frame(width: 14.6, height: 14.6)
                .foregroundColor(Color("barcolor"))
                .padding(.leading, -15)
        }
        .frame(width: 200, height: 20.5)
    }
}
