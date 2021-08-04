//
//  ColorTableViewCell.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

@objc class ColorTableViewCell: UITableViewCell {
    
   @objc var state:PaintingState?
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    @objc func configure(HEXColor: String){
        
        titleLabel.textColor = .black
        titleLabel.text = "Stroke color"
        titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22.5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19.5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        guard let stateColor = state?.color else {
            return
        }
        
        subTitleLabel.textColor = UIColor(hexString: stateColor)
        subTitleLabel.text = stateColor
        subTitleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6.5).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19.5).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let image = UIImageView(image: UIImage(named: "Right"))
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -31.5).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18).isActive = true
        image.widthAnchor.constraint(equalToConstant: 8).isActive = true
        image.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
