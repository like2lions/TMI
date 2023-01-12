//
//  BarItemStore.swift
//  TMI
//
//  Created by 박성민 on 2023/01/12.
//

import Foundation

class BarItemStore: ObservableObject {
    
    @Published var barItems: [BarItem] = []
    
    func addBarItem(_ barItem: BarItem) {
        barItems.append(barItem)
    }
    
}
