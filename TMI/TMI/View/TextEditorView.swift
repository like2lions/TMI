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
    @Binding var lineIndex: Int // 입력된 line 수 보여주기 위한 변수
    
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
        .onPreferenceChange(ViewHeightKey.self) { newHeight in
            /// newHeight가 전보다 줄어들면 lineIndex - 1을 해야하고
            /// 전보다 늘어나면 lineIndex  + 1을 해줘야한다
            /// 첫번째 줄의 경우 아무것도 입력이 안되었을 때는 30인데 뭐 하나라도 입력되면 36.3333으로 높이가 늘어나버려서 첫번째 줄임에도 lineIndex가 2로 나와버리는 문제발생
            /// 그래서 높이가 40 이하일 경우 lineIndex를 0으로 고정하였다
            // TODO: - 다른 Device에서 첫번째 줄의 높이가 어떻게 나오는지 확인해보기
            if newHeight < 40 {
                lineIndex = 0
            } else if textEditorHeight < newHeight {
                lineIndex += 1
            } else if textEditorHeight > newHeight {
                lineIndex -= 1
            }
            
            textEditorHeight = newHeight
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
        TextEditorView(text: .constant(""), textEditorHeight: .constant(0), lineIndex: .constant(0))
    }
}
