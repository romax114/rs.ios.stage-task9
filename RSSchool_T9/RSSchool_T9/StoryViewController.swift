//
//  StoryViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

class StoryViewController: UIViewController {
    
    var state: PaintingState?
    var data: Story?
    
    var storyView: StoryView?
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
        storyView = StoryView(data:data)
        guard let storyView = storyView else {return}
        self.view.backgroundColor = storyView.backgroundColor
        storyView.closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
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
        guard let storyView = storyView else {return}
        scrollView.contentSize = CGSize(width: storyView.bounds.width, height: storyView.bounds.height)
        storyView.state = self.state
        configureView()
        storyView.gradient.frame = storyView.imageView.bounds
    }
    

    func configureView() {
        guard let storyView = storyView else {return}
        self.view.addSubview(scrollView)
        scrollView.addSubview(storyView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.widthAnchor.constraint(equalTo: storyView.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        storyView.translatesAutoresizingMaskIntoConstraints = false
        storyView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        storyView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        storyView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        storyView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
 
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
}

