//
//  BarItemStore.swift
//  TMI
//
//  Created by 박성민 on 2023/01/12.
//

import Foundation

class BarStore: ObservableObject {
    
    @Published var barItems: [BarItem] = []
    
    func addBar(_ barItem: BarItem) {
        barItems.append(barItem)
    }
    
}
