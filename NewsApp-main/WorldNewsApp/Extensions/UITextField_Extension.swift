//
//  UITextField_Extension.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//

import UIKit

extension UITextField {
    
    private struct AssociatedKeys {
        static var iconName = "iconName"
    }
    
    // A computed property to get and set the iconName
    var iconName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.iconName) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.iconName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static func makeCustomTextfield(placeholderText: String?, iconName: String, isSecure: Bool, keyboardType: UIKeyboardType) -> UITextField {
        
        let element = UITextField()
        element.keyboardType = keyboardType
        element.placeholder = placeholderText
        element.textAlignment = .left
        element.layer.borderWidth = 2.0
        element.layer.cornerRadius = 15
        element.font = .systemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
    
        element.iconName = iconName // Set the iconName
        element.observeTypingState() // Call observeTypingState
        
        if (isSecure) {
            element.isSecureTextEntry = true
        }
        
        return element
    }
    
    // MARK: - Typing State Observation
    
    func observeTypingState() {
        updateAppearance(isTyping: false) // No need to pass iconName here
        addTarget(self, action: #selector(didStartTyping), for: .editingDidBegin)
        addTarget(self, action: #selector(didStopTyping), for: .editingDidEnd)
    }
    
    // MARK: - Helpers

    @objc private func didStartTyping() {
        updateAppearance(isTyping: true) // Use the stored iconName
    }

    @objc private func didStopTyping() {
        updateAppearance(isTyping: false) // Use the stored iconName
    }

    private func updateAppearance(isTyping: Bool) {
        // Access the stored iconName property
        let currentIconName = iconName ?? "pencil.circle" // Default icon if none is set
        
        if isTyping {
            // Active appearance
            self.textColor = .black
            self.backgroundColor = .white
            self.layer.borderColor = UIColor.blue.cgColor
            
            // Set icon with active color
            let activeIcon = UIImage(systemName: currentIconName)?.withRenderingMode(.alwaysTemplate)
            setIcon(activeIcon, color: .blue)
        } else {
            // Inactive appearance
            self.textColor = AppColors.grayDark
            self.backgroundColor = AppColors.purpleLighter
            self.layer.borderColor = AppColors.purpleLighter.cgColor
            
            // Set icon with inactive color
            let inactiveIcon = UIImage(systemName: currentIconName)?.withRenderingMode(.alwaysTemplate)
            setIcon(inactiveIcon, color: AppColors.grayDark)
        }
    }
    
    // Helper to set icon with color
    private func setIcon(_ icon: UIImage?, color: UIColor) {
        let iconView = UIImageView(image: icon)
        iconView.tintColor = color // Use the passed color for the icon
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let padding: CGFloat = 15
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: iconView.frame.width + padding * 2, height: iconView.frame.height))
        iconView.center = CGPoint(x: iconContainerView.frame.width / 2, y: iconContainerView.frame.height / 2)
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
    }
}
