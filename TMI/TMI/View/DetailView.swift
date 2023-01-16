//
//  DetailView.swift
//  TMI
//
//  Created by zooey on 2023/01/10.
//

import SwiftUI

struct DetailView: View {
    
    @State private var lineNumber: Int = 1
    @State private var text: String = ""
    @State var textArray: [String] = []
    @State var textEditorHeight : CGFloat = 0 // TextEditor의 높이를 구하기 위해 사용하는 변수
    @FocusState var focusField: Field?
    @ObservedObject var historyStore: HistoryStore
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: 30, height: textEditorHeight)
                TextEditorView(text: $text, textEditorHeight: $textEditorHeight)
            }
            Spacer()
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
