//
//  ImageFactory.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 02.11.2024.
//

import UIKit

final class ImageFactory {
    static func makeOnboardingImage(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
