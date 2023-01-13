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
    private var network = RequestAPI.shared
    
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
            case 5:
                loc = .Dokdo
            case 6:
                loc = .Gimpo
            case 7:
                loc = .Jeju
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
                histories.append(History(command: cmd, result: "Locations: \n 1: Seoul \n 2: Incheon \n 3: Busan \n 4: Daegu \n 5: Dokco \n 6: Gimpo \n 7: Jeju"))
                setLocOn.toggle()
            case "weather":
                network.fetchData(regionCode: regionCode)
                histories.append(History(command: cmd, result: "loc: \(loc) \nweather: \(network.weather)"))
                
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
        case .Dokdo:
            return "11E00102"
        case .Gimpo:
            return "11B20102"
        case .Jeju:
            return "11G00201"
        }
    }
}

enum Region {
    case Seoul
    case Incheon
    case Busan
    case Daegu
    case Dokdo
    case Gimpo
    case Jeju
}


class RequestAPI: ObservableObject {
    static let shared = RequestAPI()
    private init() { }
    @Published var weather: String = "맑음"
    
    
    func fetchData(regionCode: String) {
        guard let url = URL(string: "http://apis.data.go.kr/1360000/VilageFcstMsgService/getLandFcst?serviceKey=GMt2vpUCR9RRx1vj6XlA96sJew6K9xFuIpgysZi7dVu7iCK76olLJw8lxeATAk%2Bg3AqdFRQPlPtmmSxZ8B%2F5Pg%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=\(regionCode)") else {
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.weather = (apiResponse.response.body.items["item"]?.first!.wf)!
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
}
