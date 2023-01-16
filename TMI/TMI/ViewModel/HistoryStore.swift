//
//  HistoryStore.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import Foundation

class HistoryStore: ObservableObject {
    @Published var histories: [History] = []
    @Published var memos: [Memo] = []
    @Published var showingMemoView: Bool = false
    
    // PDF 만들기 버튼
    @Published var PDFUrl: URL?
    @Published var showShareSheet: Bool = false
    
    func checkCmd(cmd: String) {
        switch cmd {
        case "clear":
            histories = []
        case "ls":
            histories.append(History(command: cmd, result: "result"))
        case "memo":
            if memos.isEmpty {
                memos.append(Memo(id: UUID().uuidString, title: "", content: [], date: Date()))
            }
            showingMemoView.toggle()
        default:
            histories.append(History(command: cmd, result: "command not found: \(cmd)"))
        }
    }
    
    func checkQuit(cmd: String, contents: [String]) {
        switch cmd {
        case ":wq":
            memos[0].content = contents
            showingMemoView.toggle()
        case ":q":
            showingMemoView.toggle()
            memos[0].content = []
        default:
            memos[0].content = contents
            
        }
    }
}


