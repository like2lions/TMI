//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

enum Field: Hashable {
    case cmdLine
}

struct HomeView: View {
    @ObservedObject var historyStore: HistoryStore = HistoryStore()
    @State var cmd: String = ""
    @FocusState var focusField: Field?
    
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
                        .padding(.horizontal, 5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                TerminalBar(user: user, path: path)
                TextField("", text: $cmd)
                    .accentColor(.yellow) // 커서 색상 변경
                    .textInputAutocapitalization(.never) // 첫 글자 대문자 비활성화
                    .disableAutocorrection(true) // 자동 수정 비활성화
                    .focused($focusField, equals: .cmdLine) // 새로 생긴 textField를 focus
                    .onSubmit {
                        historyStore.checkCmd(cmd: cmd)
                        focusField = .cmdLine
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


