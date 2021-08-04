//
//  GalleryView.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

class GalleryView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    init(data: Gallery) {
        self.data = data
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupSeparator()
        setupCollectionView()
    }
    func commonInit() {
        setupImageView()
        setupSeparator()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    
    var data: Gallery?
    
    var width: CGFloat?
    var height: CGFloat?
    
    var imageDetail: ImageDetailViewController?
    let closeButton = CloseButtonCustom()
    var image: UIImage?
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return view
    }()
    let gradientLayer = UIView()
    let gradient = CAGradientLayer()
    let titleLabel: UILabel = {
        var view = UILabel()
        view.backgroundColor = .clear
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Rockwell-Regular", size: 48)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        
        return view
    }()
    let viewLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Rockwell-Regular", size: 24)
        view.textAlignment = .center
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 214, height: 0)
        view.backgroundColor = .white
        let stroke = UIView()
        stroke.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = view.center
        view.addSubview(stroke)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return view
    }()
    
    var collectionView: UICollectionView?
    
    // MARK: -  Functions
    
    fileprivate func setupImageView() {
        guard let data = data else {return}
        width = UIScreen.main.bounds.width - 40
        
        guard let width = width else {
            return
        }
        height = width * 1.34
        
        guard let height = height else {return}
        
        self.backgroundColor = .black
        self.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        imageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        imageView.image = data.coverImage
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        
        gradientLayer.layer.cornerRadius = 10
        gradientLayer.backgroundColor = .clear
        imageView.addSubview(gradientLayer)
        gradientLayer.translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        gradientLayer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        gradientLayer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0).isActive = true
        gradientLayer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true
        
        let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [colorTop,colorBottom]
        gradient.locations = [0.74, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.9, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradient.frame = gradientLayer.bounds
        gradientLayer.layer.addSublayer(gradient)
        
        imageView.addSubview(titleLabel)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        titleLabel.attributedText = NSMutableAttributedString(string: data.title, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 314).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 116).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -55).isActive = true
        
        self.addSubview(viewLabel)
        viewLabel.backgroundColor = .black
        viewLabel.text = data.type
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0).isActive = true
        viewLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true
        viewLabel.widthAnchor.constraint(equalToConstant: 122).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func setupSeparator() {
        
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lineView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 39).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 214).isActive = true
    }
    
    fileprivate func setupCollectionView() {
        guard let data = data else {return}
        width = UIScreen.main.bounds.width - 40
        guard let width = width else {return}
        height = width * 1.37
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let minimumLineSpacing: CGFloat = 20
        layout.minimumLineSpacing = minimumLineSpacing
        let minimumInteritemSpacing: CGFloat = 20
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        let itemSizeWidth = width
        guard let height = height else {return}
        let itemSizeHeight = height
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        let heightOfCollectionView = (height*CGFloat(data.images.count)) + (minimumInteritemSpacing*CGFloat(data.images.count))
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor , constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heightOfCollectionView).isActive = true
        print(collectionView.intrinsicContentSize)
    }
    

    // MARK: - CollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {return 0}
        return data.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        guard let data = data else {return cell}
        cell.backgroundColor = .clear
        let image: UIImage = data.images[indexPath.row]
        cell.configure(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        width = UIScreen.main.bounds.width - 40
        guard let width = width else {return CGSize(width: 100, height: 100)}
        height = width * 1.37
        guard let height = height else {return CGSize(width: 100, height: 100)}
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = data else {return}
        let imageVC = ImageScrollViewController()
        imageVC.image = data.images[indexPath.row]
        imageVC.isModalInPresentation = true
        imageVC.modalPresentationStyle = .fullScreen
        UIViewController.topMostController()?.present(imageVC, animated: true, completion: nil)
    }
    
    
}

extension UIViewController {
    class func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}
