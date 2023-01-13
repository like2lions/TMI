//
//  HistoryStore.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import Foundation

class HistoryStore: ObservableObject {
    @Published var histories: [History] = []
    @Published var loc: Region = .Seoul
    @Published var setLocOn: Bool = false
    var regionCode: String  {
        getRegionCode(region: loc)
    }
    
    var availableCmd: [String] = ["clear", "ls", "set loc"]
    
    func checkCmd(cmd: String) {
        if setLocOn {
            switch Int(cmd) ?? 0 {
            case 1:
                loc = .Seoul
            case 2:
                loc = .Incheon
            case 3:
                loc = .Busan
            case 4:
                loc = .Daegu
            default:
                print("Unknown")
            }
            histories.append(History(command: cmd))
            setLocOn.toggle()
        } else {
            switch cmd {
            case "clear":
                histories = []
            case "ls":
                histories.append(History(command: cmd, result: "result"))
            case "loc":
                histories.append(History(command: cmd, result: "Current Location: \(loc)"))
            case "set loc":
                histories.append(History(command: cmd, result: "Locations: \n 1: Seoul \n 2: Incheon \n 3: Busan \n 4: Daegu"))
                setLocOn.toggle()
            default:
                histories.append(History(command: cmd, result: "command not found: \(cmd)"))
                
            }
        }
    }
    
    func getRegionCode(region: Region) -> String {
        switch region {
        case .Seoul:
            return "11B10101"
        case .Incheon:
            return "11B20201"
        case .Busan:
            return "11H20201"
        case .Daegu:
            return "11H10701"
        }
    }
}

enum Region {
    case Seoul
    case Incheon
    case Busan
    case Daegu
}
