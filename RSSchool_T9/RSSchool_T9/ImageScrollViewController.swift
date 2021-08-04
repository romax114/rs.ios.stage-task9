//
//  ImageScrollViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

class ImageScrollViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = image else {return}
        configureView(image: image)
    }
    

    func configureView(image: UIImage)  {
        let scrollView = UIScrollView()
        self.view.backgroundColor = .black
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrollView.delegate = self
        let fullImageView = UIImageView()
        let img = image
        var aspectRatio: CGFloat?
        if img.size.width > img.size.height{
        aspectRatio = img.size.width / img.size.height
        } else {
        aspectRatio = img.size.height / img.size.width
        }
        guard let aspectRatioU = aspectRatio else {return}
        scrollView.frame = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        fullImageView.image = image
        fullImageView.enableZoom()
        fullImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(fullImageView)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fullImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        fullImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        
        fullImageView.heightAnchor.constraint(equalTo: fullImageView.widthAnchor, multiplier: aspectRatioU).isActive = true
        let closeBtn = CloseButtonCustom()
        self.view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }

}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
