//
//  UIFont + Extension.swift
//  WorldNewsApp
//
//  Created by vp.off on 26.10.2024.
//

import UIKit

extension UIFont {
    enum Inter {
        enum bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Inter.bold, size: size)!
            }
        }
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Inter.medium, size: size)!
            }
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Inter.regular, size: size)!
            }
        }
        enum semibold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constans.Inter.bold, size: size)! }
        }
    }
}

extension UIFont {
    fileprivate enum Constans {
        enum Inter {
            static let bold = "Inter-Bold"
            static let medium = "Inter-Medium"
            static let regular = "Inter-Regular"
            static let semiBold = "Inter-SemiBold"
        }
    }
}
