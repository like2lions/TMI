//
//  FirstLottie.swift
//  TMI
//
//  Created by 김응관 on 2023/01/10.
//

import SwiftUI
import Foundation
import Lottie
import UIKit

struct LottieManager: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var filename: String

    
    init(jsonName: String = ""){
        self.filename = jsonName
    }
        
    func makeUIView(context: UIViewRepresentableContext<LottieManager>) -> UIView {
            let view = UIView(frame: .zero)

            let animationView = LottieAnimationView()
        
            let animation = LottieAnimation.named(filename)
            animationView.animation = animation
        
            // AspectFit으로 적절한 크기의 에니매이션을 불러옵니다.
            animationView.contentMode = .scaleAspectFit
        
            // 애니메이션은 기본으로 Loop합니다.
            animationView.loopMode = .loop
        
            // 애니메이션을 재생합니다
            animationView.play()
        
            // 백그라운드에서 재생이 멈추는 오류를 잡습니다
            animationView.backgroundBehavior = .pauseAndRestore

      //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록합니다. 로티는 컨테이너 위에 작성됩니다.
      
      
          animationView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(animationView)
             //레이아웃의 높이와 넓이의 제약
            NSLayoutConstraint.activate([
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])

            return view
        }
    
        //2. Context -> UIViewRepresentableContext<LottieView>로 수정
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieManager>) {
        // do nothing
    }
}

