//
//  HistoryStore.swift
//  TMI
//
//  Created by do hee kim on 2023/01/12.
//

import Foundation

class HistoryStore: ObservableObject {
    @Published var histories: [History] = []
    @Published var loc: String = "seoul"
    @Published var setLocOn: Bool = false
    
    var availableCmd: [String] = ["clear", "ls", "set loc"]
    
    func checkCmd(cmd: String) {
        if setLocOn {
            switch Int(cmd) ?? 0 {
            case 1:
                print("seoul")
                loc = "Seoul"
            case 2:
                print("Incheon")
                loc = "Incheon"
            case 3:
                print("Busan")
                loc = "Busan"
            case 4:
                print("Daegu")
                loc = "Daegu"
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
    
    func setLocConfig(loc: String) {
        // loc validation check
        
        // change the current loc
    }
}
