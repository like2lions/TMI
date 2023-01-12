//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var historyStore: HistoryStore = HistoryStore()
    @State var cmd: String = ""
    var user = "Chap"
    var path = "~"
    
    var body: some View {
        ScrollView {
            ForEach(historyStore.histories) { history in
                VStack(alignment: .leading) {
                    HStack {
                        TerminalBar(user: user, path: path)
                        Text(history.command)
                    }
                    Text(history.result)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                TerminalBar(user: user, path: path)
                TextField("", text: $cmd)
                    .onSubmit {
                        historyStore.histories.append(History(command: cmd, result: "result"))
                        cmd = ""
                    }
                    .frame(maxWidth: .infinity)
                    
            }
            
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


