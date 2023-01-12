//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 1) {
            TerminalBar(user: "Chap", path: "~")
            TerminalBar(user: "Chap", path: "~/Desktop")
            Spacer()
        }
        .padding(.top, 1)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


