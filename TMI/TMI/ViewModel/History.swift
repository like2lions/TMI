//
//  History.swift
//  TMI
//
//  Created by 김응관 on 2023/01/12.
//

import Foundation

class History: ObservableObject {
    @Published var history: [CmdLine]
    
    init(history: [CmdLine] = []){
        self.history = history
    }
}
