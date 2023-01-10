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
    
    var body: some View {
        
        VStack(spacing: 0) {
                ForEach(Array(textArray.enumerated()), id: \.offset) { index, text in
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
              
            HStack {
                ZStack {
                    Rectangle()
                        .frame(width: 30, height: 30)
                    Text("\(lineNumber)")
                        .foregroundColor(.white)
                }
                
                TextField("내용을 입력하세요", text: $text)
            }
            Spacer()
        }
        .onSubmit {
            textArray.append(text)
            lineNumber += 1
            text = ""
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
