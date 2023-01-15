//
//  HistoryStore.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import Foundation

class HistoryStore: ObservableObject {
    @Published var histories: [History] = []
    @Published var showingMemoView: Bool = false
    
    func checkCmd(cmd: String) {
        switch cmd {
        case "clear":
            histories = []
        case "ls":
            histories.append(History(command: cmd, result: "result"))
        case "memo":
            showingMemoView.toggle()
        default:
            histories.append(History(command: cmd, result: "command not found: \(cmd)"))
        }
    }
}
