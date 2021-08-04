//
//  ImageDetailViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func configureView(){
        let closeButtonAtImageView = CloseButtonCustom()
        self.view.addSubview(closeButtonAtImageView)
        closeButtonAtImageView.translatesAutoresizingMaskIntoConstraints = false
        closeButtonAtImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        closeButtonAtImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        closeButtonAtImageView.addTarget(self, action: #selector(closeImageView), for: .touchUpInside)
    }
    
    @objc func closeImageView() {
        
    }
}
