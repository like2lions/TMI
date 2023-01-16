//
//  Memo.swift
//  TMI
//
//  Created by 박성민 on 2023/01/10.
//

import Foundation

// MARK: - Memo 구조체
struct Memo: Identifiable {
    
    var id: String
    var title: String
    var content: [String]
    var date: Date
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
