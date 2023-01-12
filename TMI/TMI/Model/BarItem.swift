//
//  BarItem.swift
//  TMI
//
//  Created by 박성민 on 2023/01/12.
//

import Foundation

struct BarItem {
    var id = UUID().uuidString
    var user: String
    var path: String
    var command: String
}
