//
//  TerminalBar.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import SwiftUI

struct TerminalBar: View {
    let user: String
    let path: String
    
    let firstColor: Color = .black
    let secondColor: Color = .yellow
    let fontColor: Color = .white
    
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: weatherViewModel.weatherIcon)
                    .foregroundColor(fontColor)
                    .frame(height: 30)
                    .padding(.leading, 5)
                    .background {
                        Rectangle()
                            .foregroundColor(firstColor)
                    }
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
        }
    }
}

struct TerminalBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
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
