//
//  DrawTableViewCell.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

@objc class DrawTableViewCell: UITableViewCell {
   @objc var state: PaintingState?
    
    
   @objc func configure(switchIsOn: Bool)  {
        let switchBtn = UISwitch()
    guard let stateIson = state?.isSwitchedOn else {
        return
    }
    switchBtn.isOn = stateIson
        switchBtn.addTarget(self, action: #selector(switched), for: .valueChanged)
        contentView.addSubview(switchBtn)
        switchBtn.translatesAutoresizingMaskIntoConstraints = false
        switchBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        switchBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.5).isActive = true
        switchBtn.widthAnchor.constraint(equalToConstant: 51).isActive = true
        switchBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17.0)
        label.text = "Draw stories"
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.5).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19.5).isActive = true
        label.trailingAnchor.constraint(equalTo: switchBtn.leadingAnchor, constant: -8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    @objc func switched(){
        guard let stateU = state else {
            return
        }
        stateU.isSwitchedOn = !stateU.isSwitchedOn
    }

}
