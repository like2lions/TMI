//
//  BarItemHistoryView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/12.
//

import SwiftUI

struct BarItemHistoryView: View {
    var barItem: BarItem
    
    var body: some View {
        HStack {
            terminalBar(user: barItem.user, path: barItem.path)
            Text(barItem.command)
            Spacer()
        }
    }
}

struct BarItemHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BarItemHistoryView(barItem: BarItem(user: "chap", path: "~", command: "cd folder"))
    }
}
