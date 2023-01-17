//
//  FileMangerService.swift
//  TMI
//
//  Created by 박성민 on 2023/01/18.
//

import Foundation
import SwiftUI

class FileMangerService: ObservableObject {
    
    @Published var fileData: String = ""
    @Published var fileList: [String] = []
    
    // FileManager 인스턴스 생성
    let fileManager: FileManager = FileManager.default
    // 사용자의 문서 경로
    var documentPath: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // 문서경로에 폴더 만들기
    func createFolder(foderName: String) {
        do {
            // 폴더 위치
            let directoryPath: URL = documentPath.appendingPathComponent("\(foderName)")
            // 아까 만든 디렉토리 경로에 디렉토리 생성 (폴더가 만들어진다.)
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    // 문서경로에 파일 만들기(.txt, .md)
    // 같은경로 같은 이름 파일은 수정 content만 바꾸면 수정 가능
    func createFile(forderName: String, fileNameExtension: String, content: String) {
        // 파일 경로
        let directoryPath: URL = documentPath.appendingPathComponent("\(forderName)")
        let textPath: URL = directoryPath.appendingPathComponent("\(fileNameExtension)")
        if let data: Data =
            """
            \(content)
            """
            .data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 쓰기
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // 파일 데이터 불러오기
    
    func loadFileData(forderName: String, fileNameExtension: String) {
        // 파일 경로
        let directoryPath: URL = documentPath.appendingPathComponent("\(forderName)")
        let textPath: URL = directoryPath.appendingPathComponent("\(fileNameExtension)")
        do {
            let dataFromPath: Data = try Data(contentsOf: textPath) // URL을 불러와서 Data타입으로 초기화
            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
            print(text) // 출력
            fileData = text

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // 파일 리스트 불러오기
    func loadFileList(forderName: String) {
        let directoryPath: URL = documentPath.appendingPathComponent("\(forderName)")
        do {
            let files = try fileManager.contentsOfDirectory(atPath: directoryPath.path)

            for file in files {
                fileList.append(file)
            }
            
        } catch {
            print("failed to read directory")
        }
    }
}
