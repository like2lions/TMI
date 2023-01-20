//
//  DetailView.swift
//  TMI
//
//  Created by zooey on 2023/01/10.
//

import SwiftUI

struct DetailView: View {
//    @ObservedObject var historyStore: HistoryStore
    @ObservedObject var memoViewModel: MemoViewModel
    
    @State var cmd: String = ""
    
    @State private var lineNumber: Int = 1
    @State var text: String = ""
    @State var textArray: [String] = []
    @State var textEditorHeight : CGFloat = 0 // TextEditor의 높이를 구하기 위해 사용하는 변수
    @State var lineIndex: Int = 0 // 입력된 line 수 보여주기 위한 변수
    @FocusState var focusField: Field?
    
    @State var memoIndex: Int
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top, spacing: 0) {
                // lineNumber Rectangle
                VStack(spacing: 0) {
                    ForEach(0...lineFormula(texts: text), id: \.self) { num in
                        Rectangle()
                            .frame(width: 35, height: 24)
                            .overlay {
                                Text("\(num + 1)")
                                    .foregroundColor(.white)
                            }
                    }
                }
                // textEditor
//                TextEditorView(memoViewModel: memoViewModel, text: $text, textEditorHeight: $textEditorHeight, lineIndex: $lineIndex, memoIndex: $memoIndex)
                TextEditor(text: $text)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("esc") {
                                cmd = "esc"
                            }
                            Button(":q") {
                                cmd = ":q"
                                memoViewModel.DetailViewCheckCmd(cmd: cmd, memoIndex: memoIndex, content: text)
                            }
                            Button(":wq") {
                                cmd = ":wq"
                                memoViewModel.DetailViewCheckCmd(cmd: cmd, memoIndex: memoIndex, content: text)
                            }
                            Button("clear") {
                                cmd = "clear"
                            }
                        }
                    }
            }
            Spacer()
            
            TextField("", text: $cmd)
                
            
            HStack {
                Spacer()
                Button {
                    exportPDF {
                        self
                    } completion: { status, url in
                        if let url = url, status {
                            memoViewModel.PDFUrl = url
                            memoViewModel.showShareSheet.toggle()
                        } else {
                            print("Failed to produce PDF")
                        }
                    }
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .padding()
                }
            }
        }
        .sheet(isPresented: $memoViewModel.showShareSheet) {
            memoViewModel.PDFUrl = nil
        } content: {
            if let PDFUrl = memoViewModel.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
        .onAppear {
            if memoIndex >= 0 {
                text = self.memoViewModel.memos[memoIndex].content
                lineIndex = lineFormula(texts: memoViewModel.memos[memoIndex].content)
            }
        }
    }
    // MARK: - 적힌 메모의 행 수를 세는 메서드
    func lineFormula(texts: String) -> Int {
        return texts.components(separatedBy: "\n").count
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(historyStore: HistoryStore(), memoViewModel: MemoViewModel())
//    }
//}

struct ShareSheet: UIViewControllerRepresentable {
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
