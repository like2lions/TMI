//
//  TextEditorView.swift
//  TMI
//
//  Created by do hee kim on 2023/01/16.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    @Binding var textEditorHeight: CGFloat // TextEditor의 높이를 구하기 위해 사용하는 변수
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .font(.system(.body))
                .foregroundColor(.clear)
                .padding(8)
                .background(GeometryReader { proxy in
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: proxy.size.height)
                })
            TextEditor(text: $text)
                .font(.system(.body))
                .frame(height: max(40,textEditorHeight))
                .cornerRadius(10.0)
        }
        .onPreferenceChange(ViewHeightKey.self) { newValue in
            textEditorHeight = newValue
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant(""), textEditorHeight: .constant(0))
    }
}
