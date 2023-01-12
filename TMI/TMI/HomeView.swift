//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

struct HomeView: View {
    
    @State private var commandText: String = ""
    @State private var tilde: String = "~"
    @State private var slash: String = "/"
    @State private var commandAll: [String] = []
    @State private var indexNumber: Int = -1
    
    var body: some View {
        
        VStack(spacing: 0) {
            ForEach(Array(commandAll.enumerated()), id: \.offset) { index, text in
                
                HStack {
                    
                    terminalBar(user: "Chap", path: text)
                    Text("\(index + 1)")
                        .foregroundColor(.white)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if commandAll == [] {
                HStack(spacing: 0) {
                    terminalBar(user: "Chap", path: tilde)
                    TextField("명령어를 입력해주세요", text: $commandText)
                }
            } else {
                HStack(spacing: 0) {
                    ZStack {
                        terminalBar(user: "Chap", path: commandAll[indexNumber])
                    }
                    TextField("명령어를 입력해주세요", text: $commandText)
                }
            }
            Spacer()
        }
        .onSubmit {
            commandAll.append(tilde + slash + commandText)
            commandText = ""
            indexNumber += 1
        }
        .padding(.top, 1)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct terminalBar: View {
    let user: String
    let path: String
    
    let firstColor: Color = .black
    let secondColor: Color = .yellow
    let fontColor: Color = .white
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("\(user)")
                    .bold()
                    .padding(.horizontal, 10)
                    .frame(height: 30)
                    .foregroundColor(fontColor)
                    .background(firstColor)
                ZStack {
                    MyShape()
                        .foregroundColor(firstColor)
                    MyShape2()
                        .foregroundColor(secondColor)
                }
                .frame(width: 20, height: 30)
                Text("\(path)")
                    .bold()
                    .padding(.horizontal, 10)
                    .frame(height: 30)
                    .foregroundColor(fontColor)
                    .background(secondColor)
                MyShape()
                    .foregroundColor(secondColor)
                    .frame(width: 20, height: 30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        //        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
        //            control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: (rect.minY + rect.maxY) / 2))
        path.closeSubpath()
        return path
    }
}

struct MyShape2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: (rect.minY + rect.maxY) / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
