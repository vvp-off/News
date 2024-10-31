//
//  UIView + ext.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 27.10.2024.
//

import UIKit.UIView

extension UIView {
    func addSomeSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
    
    func disableChildrenTAMIC() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
