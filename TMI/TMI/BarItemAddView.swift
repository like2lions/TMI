//
//  BarItemAddView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/12.
//

import SwiftUI

struct BarItemAddView: View {
    @StateObject var barStore: BarItemStore
    @State var path: String = "~"
    @State var command: String = ""
    var body: some View {
        HStack {
            terminalBar(user: "Chap", path: path)
            TextField("명령", text: $command)
                .onSubmit {
                    barStore.addBarItem(BarItem(user: "chap", path: path, command: command))
                    command = ""
                }
        }
    }
}

struct BarItemAddView_Previews: PreviewProvider {
    static var previews: some View {
        BarItemAddView(barStore: BarItemStore())
    }
}
