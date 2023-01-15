//
// PDFRenderer.swift
//  TMI
//
//  Created by zooey on 2023/01/15.
//

import SwiftUI
import UIKit

extension View {
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> UIScrollView {
        
        let scrollview = UIScrollView()
        
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostingController.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollview.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        scrollview.addSubview(hostingController)
        scrollview.addConstraints(constraints)
        scrollview.layoutIfNeeded()
        
        return scrollview
    }
    
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func exportPDF<Content: View>(@ViewBuilder content: @escaping () -> Content, completion: @escaping (Bool, URL?) -> ()) {
        
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                         in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("title.pdf")
        let pdfView = convertToScrollView {
            content()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        
        pdfView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        getRootController().view.insertSubview(pdfView, at: 0)
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x:0, y:0, width: size.width, height: size.height))
        
        do {
            try renderer.writePDF(to: outputFileURL, withActions: { context in
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            completion(true, outputFileURL)
        } catch {
            completion(false, nil)
            print(error.localizedDescription)
        }
        
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009 {
                print("Removed")
                view.removeFromSuperview()
            }
        }
    }
    
    func getRootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}

