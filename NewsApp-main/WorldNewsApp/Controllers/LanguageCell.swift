//
//  LanguageCell.swift
//  WorldNewsApp
//
//

import UIKit

// MARK: - Custom TableViewCell
class LanguageCell: UITableViewCell {
    static let identifier = "LanguageCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Inter.bold.size(of: 16)
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            // Констрейнты для containerView
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Констрейнты для titleLabel и checkmarkImageView
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with language: String, isSelected: Bool) {
        titleLabel.text = language
        
        if isSelected {
            containerView.backgroundColor = AppColors.purplePrimary
            titleLabel.textColor = .white
            checkmarkImageView.isHidden = false
        } else {
            containerView.backgroundColor = AppColors.grayLighter
            titleLabel.textColor = AppColors.grayDark
            checkmarkImageView.isHidden = true
        }
    }
}
