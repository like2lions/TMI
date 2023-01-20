////
////  HistoryStore.swift
////  TMI
////
////  Created by do hee kim on 2023/01/12.
////
//
//import Foundation
//
//class HistoryStore: ObservableObject {
//    @Published var histories: [History] = []
//    @Published var showingMemoView: Bool = false
//    
//    // PDF 만들기 버튼
//    @Published var PDFUrl: URL?
//    @Published var showShareSheet: Bool = false
//    
//    func checkCmd(cmd: String) {
//        let command = cmd.split(separator: " ")[0]
//        
//        switch command {
//        case "clear":
//            histories = []
//        case "ls":
//            histories.append(History(command: cmd, result: "result"))
//        case "memo":
//            let title = cmd.replacingOccurrences(of: "memo ", with: "")
//            if let targetNum = Int(title) {
//                selectedTodoListIndex = targetNum - 1
//            } else {
//                for (i, todoList) in todoListStore.todoLists.enumerated() {
//                    if todoList.todoListTitle == title {
//                        selectedTodoListIndex = i
//                    }
//                }
//            }
//            showingMemoView.toggle()
//        default:
//            histories.append(History(command: cmd, result: "command not found: \(cmd)"))
//        }
//    }
//    
//    func memoCmd(cmd: String) -> Int {
//        let title = cmd.replacingOccurrences(of: "memo ", with: "")
//        if let targetNum = Int(title) {
//            return targetNum - 1
//        } else {
//            for (i, memoList) in todoListStore.todoLists.enumerated() {
//                if todoList.todoListTitle == title {
//                    return i
//                }
//            }
//        }
//    }
//}
//
//
