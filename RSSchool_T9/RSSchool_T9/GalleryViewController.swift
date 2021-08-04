//
//  GalleryViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var data: Gallery?
    
    var galleryView: GalleryView?
    let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = data else {return}
        galleryView = GalleryView(data: data)
        guard let galleryView = galleryView else {return}
        self.view.backgroundColor = galleryView.backgroundColor
        galleryView.closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let galleryView = galleryView else {return}
        configureView()
        scrollView.contentSize = CGSize(width: galleryView.bounds.width, height: galleryView.bounds.height)
        galleryView.gradient.frame = galleryView.imageView.bounds
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let galleryView = galleryView else {return}
        scrollView.contentSize = CGSize(width: galleryView.bounds.width, height: galleryView.bounds.height)
    }
    
    func configureView() {
        guard let galleryView = galleryView else {return}
        self.view.addSubview(scrollView)
        scrollView.addSubview(galleryView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        galleryView.translatesAutoresizingMaskIntoConstraints = false
        galleryView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        galleryView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        galleryView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        galleryView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    
    
    @objc func closeView(){
        dismiss(animated: true, completion: nil)
    }

}
