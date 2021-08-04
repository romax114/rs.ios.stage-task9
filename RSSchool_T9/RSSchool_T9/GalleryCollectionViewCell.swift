//
//  GalleryCollectionViewCell.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GalleryCollectionViewCell"
    let layer0 = CAGradientLayer()
    
    func configure (typeLabelText: String, titleLabelText: String, image: UIImage?){
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true

        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 10
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.04).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.04).isActive = true

        let gradientLayer = UIView()
        gradientLayer.layer.cornerRadius = 10
        gradientLayer.backgroundColor = .clear
        imageView.addSubview(gradientLayer)
        gradientLayer.translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        gradientLayer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        gradientLayer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0).isActive = true
        gradientLayer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true
        
        layer0.colors = [
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        layer0.locations = [0.74, 1]
        layer0.startPoint = CGPoint(x: 0.1, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.8, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = gradientLayer.bounds.insetBy(dx: -0.5*gradientLayer.bounds.size.width, dy: -0.5*gradientLayer.bounds.size.height)
        layer0.position = gradientLayer.center
        imageView.clipsToBounds = true
    
        gradientLayer.layer.addSublayer(layer0)
        layer0.frame  = gradientLayer.bounds
 
        let typeLabel = UILabel()
        typeLabel.textColor = .white
        typeLabel.font = UIFont(name: "Rockwell-Regular", size: 16)
        typeLabel.textAlignment = .left
        typeLabel.text = typeLabelText
        typeLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 9.96).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Rockwell-Regular", size: 12)
        titleLabel.textColor = #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7137254902, alpha: 1)
        titleLabel.text = titleLabelText
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -13).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10.04).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer0.frame = contentView.bounds
    }
}
