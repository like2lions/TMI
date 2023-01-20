//
//  MemoViewModel.swift
//  TMI
//
//  Created by do hee kim on 2023/01/20.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var histories: [History] = []
    @Published var memos: [Memo] = []
    @Published var isShowingDetailView: Bool = false
    
    // PDF 만들기 버튼
    @Published var PDFUrl: URL?
    @Published var showShareSheet: Bool = false
    
    func HomeViewCheckCmd(cmd: String) -> Int {
        let command = cmd.split(separator: " ")[0]
        
        print(command)
        
        switch command {
        case "clear":
            histories = []
            return -1
        case "ls":
            histories.append(History(command: cmd, result: "result"))
            return -1
        case "memo":
            print("[memo] \(memos)")
            let title = cmd.replacingOccurrences(of: "memo ", with: "")
            print("[title] \(title)")
            // memo 1 -> title을 다쓰지 않고 index 값으로 들어가기
            if let targetNum = Int(title) {
                isShowingDetailView.toggle()
                return targetNum - 1
            } else {
                // memo memo1 -> title을 다 쓰고 들어가기
                for (i, memo) in memos.enumerated() {
                    if memo.title == title {
                        isShowingDetailView.toggle()
                        return i
                    }
                }
            }
            isShowingDetailView.toggle()
        default:
            histories.append(History(command: cmd, result: "command not found: \(cmd)"))
            return -1
        }
        return -1
    }
    
    func DetailViewCheckCmd(cmd: String, memoIndex: Int, content: String) {
        switch cmd {
        case "esc":
            print("esc")
        case ":q":
            print(":q")
            isShowingDetailView.toggle()
        case ":wq":
            print(":wq")
            if memoIndex == -1 {
                memos.append(Memo(id: UUID().uuidString, title: "", content: content, date: Date()))
            } else {
                memos[memoIndex].content = content
            }
            print(memos)
            isShowingDetailView.toggle()
        case "clear":
            print("clear")
        default:
            print("default")
        }
    }
}
