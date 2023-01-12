//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

struct HomeView: View {
    @State private var cmd: String = ""
    @State private var cmdHistory: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 1) {
                ForEach(cmdHistory, id: \.self) { history in
                    HStack {
                        terminalBar(user: "Chap", path: "~")
                        Text("\(history)")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    terminalBar(user: "Chap", path: "~")
                    TextField("", text: $cmd)
                        .accentColor(.yellow)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            cmdHistory.append(cmd)
                            cmd = ""
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 1)
        }
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
            .frame(alignment: .leading)
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
