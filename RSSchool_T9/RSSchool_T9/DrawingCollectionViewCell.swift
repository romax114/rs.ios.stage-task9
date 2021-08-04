//
//  DrawingCollectionViewCell.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

class DrawingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DrawingCollectionViewCell"
    var state: PaintingState?
    lazy var view: UIView = {
        let view = UIView()
        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        return view
    }()
    
    func animate(isSwitchedOn: Bool,path: CGPath,animation: CABasicAnimation) {
        guard let state = state else {return}
        view.backgroundColor = .clear
        let layer = CAShapeLayer()
        layer.path = path
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor(hexString: state.color).cgColor
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        layer.lineWidth = 0.5
        layer.lineJoin = CAShapeLayerLineJoin.round
        view.layer.addSublayer(layer)
        
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        guard let state = state else {return}
//        if state.isSwitchedOn {
//            anim()
//        } else {
//            anim1()
//        }
//    }
    
    func anim() {
            let anim1 = CABasicAnimation(keyPath: "strokeEnd")
            anim1.fromValue         = 0.0
            anim1.toValue           = 1.0
        anim1.duration          = 3.0
            anim1.repeatCount       = 0
            anim1.autoreverses      = false
            anim1.isRemovedOnCompletion = false
        anim1.isAdditive = true
        anim1.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(anim1, forKey: "strokeEnd")
        }
    func anim1() {
            let anim1 = CABasicAnimation(keyPath: "strokeEnd")
            anim1.fromValue         = 1.0
            anim1.toValue           = 1.0
        anim1.duration          = 3.0
            anim1.repeatCount       = 0
            anim1.autoreverses      = false
            anim1.isRemovedOnCompletion = false
        anim1.isAdditive = true
        anim1.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(anim1, forKey: "strokeEnd")
        }
}
