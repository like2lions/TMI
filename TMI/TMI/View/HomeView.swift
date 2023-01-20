//
//  HomeView.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import SwiftUI

enum Field: Hashable {
    case cmdLine
    case detailText
}

struct HomeView: View {
//    @ObservedObject var historyStore: HistoryStore = HistoryStore()
    @ObservedObject var memoViewModel: MemoViewModel = MemoViewModel()
    
    @State var cmd: String = ""
    @FocusState var focusField: Field?
    
    @ObservedObject var weatherViewModel: WeatherViewModel = WeatherViewModel()
    
    @State var memoIndex: Int = -1
    
    var user = "Chap"
    var path = "~"
    
    var body: some View {
        
        VStack {
            WeatherTestView(weatherViewModel: weatherViewModel)
            ScrollView {
                ForEach(memoViewModel.histories) { history in
                    VStack(alignment: .leading) {
                        HStack {
                            TerminalBar(user: user, path: path, weatherViewModel: weatherViewModel)
                            Text(history.command)
                        }
                        Text(history.result)
                            .padding(.horizontal, 5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    TerminalBar(user: user, path: path, weatherViewModel: weatherViewModel)
                    TextField("", text: $cmd)
                        .accentColor(.yellow) // 커서 색상 변경
                        .textInputAutocapitalization(.never) // 첫 글자 대문자 비활성화
                        .disableAutocorrection(true) // 자동 수정 비활성화
                        .focused($focusField, equals: .cmdLine) // 새로 생긴 textField를 focus
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Button("clear") {
                                    cmd = "clear"
                                }
                                Button("ls") {
                                    cmd = "ls"
                                }
                                Button("cd") {
                                    cmd = "cd"
                                }
                                Button("memo") {
                                    cmd = "memo"
                                    memoViewModel.isShowingDetailView = true
                                }
                                // MARK: fullScreenCover로 띄울 시 keyboard tool bar가 나오지 않는 문제 발생해서 navigationLink로 수정하였습니다.
//                                .fullScreenCover(isPresented: $historyStore.showingMemoView) {
//                                    DetailView(historyStore: historyStore)
//                                }
                            }
                        }
                        .onSubmit {
                            memoIndex = memoViewModel.HomeViewCheckCmd(cmd: cmd)
                            focusField = .cmdLine
                            cmd = ""
                            print("[return memoIndex] \(memoIndex)")
                            print(memoViewModel.isShowingDetailView)
                        }
                        .frame(maxWidth: .infinity)
                }
                Spacer()
            }
        }
        .onAppear {
            weatherViewModel.loadWeatherData { Forecast in
                
            }
        }
        .navigationDestination(isPresented: $memoViewModel.isShowingDetailView) {
            DetailView(memoViewModel: memoViewModel, memoIndex: memoIndex)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


