//
//  DetailView.swift
//  TMI
//
//  Created by zooey on 2023/01/10.
//

import SwiftUI

struct DetailView: View {

    @State private var text: String = ""
    @State var textArray: [String] = []
    @FocusState var focusField: Field?
    @ObservedObject var historyStore: HistoryStore
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(historyStore.memos[0].content.enumerated()), id: \.offset) { index, text in
                        HStack {
                            ZStack {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                Text("\(index + 1)")
                                    .foregroundColor(.white)
                            }

                            Text(text)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    //새로이 입력되는 것들이 출력되는 공간
                    ForEach(Array(textArray.enumerated()), id: \.offset) { index, text in
                        HStack {
                            ZStack {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                Text("\(index + 1 + historyStore.memos[0].lines)")
                                    .foregroundColor(.white)
                            }

                            Text(text)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    // 텍스트필드 입력 공간
                    HStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 30, height: 30)
                            Text("\(historyStore.memos[0].lines + textArray.count + 1)")
                                .foregroundColor(.white)
                        }
                        
                        TextField("내용을 입력하세요", text: $text)
                            .focused($focusField, equals: .detailText)
                    }
                    Spacer()
                }
            }
            .onSubmit {
                textArray.append(text)
                
                let newMemo = updateMemo(before: historyStore.memos[0].content, new: textArray)
                
                historyStore.checkQuit(cmd: text, contents: newMemo)
                
                text = ""
                focusField = .detailText
            }
            
            HStack {
                Spacer()
                Button {
                    exportPDF {
                        self
                    } completion: { status, url in
                        if let url = url, status {
                            historyStore.PDFUrl = url
                            historyStore.showShareSheet.toggle()
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
        .sheet(isPresented: $historyStore.showShareSheet) {
            historyStore.PDFUrl = nil
        } content: {
            if let PDFUrl = historyStore.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
    }
    
    
    func updateMemo(before: [String], new: [String]) -> [String] {
        print(before)
        print(new)
        
        var newMemo: [String] = []
        var tmp: [String] = []
        
        if new.last == ":wq" {
            tmp = new
            tmp.removeLast()
            textArray = tmp
            
            historyStore.memos[0].lines += tmp.count
            newMemo += before
            newMemo += tmp
        }
        else if new.last == ":q" {
            textArray = []
        
            print(before)
            return before
        }
        else {
            newMemo += new
        }
        
        return newMemo
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(historyStore: HistoryStore())
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
