//
//  TransitionManager.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 31.10.2024.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    //   длительность в сек
    let duration = 0.5
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        //        получаем контроллер для перехода
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        let conteinetVeiw = transitionContext.containerView
        //        конечное положение после анимации
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        // Начальная позиция - за правым краем экрана
        toView.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        conteinetVeiw.addSubview(toView)
        
        //        Анимация появления
        UIView.animate(withDuration: duration,
                       animations: { toView.frame = finalFrame
        })  {_ in
            transitionContext.completeTransition(true)
        }
    }
}
