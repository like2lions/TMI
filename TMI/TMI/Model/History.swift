//
//  History.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import Foundation

struct History: Identifiable {
    var id = UUID().uuidString
    var command: String
    var result: String?
}
