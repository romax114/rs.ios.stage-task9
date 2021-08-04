//
//  StoryView.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/3/21.
//

import UIKit

class StoryView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var state: PaintingState?
    var data: Story?
    
    init(data: Story) {
        self.data = data
        super.init(frame: .zero)
        commonInit()
    }
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        setupImageView()
        setupSeparator()
        configureCollectionView()
        setupTextView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = gradientLayer.bounds
    }
    
    // MARK: - Property
    
    var width: CGFloat?
    var height: CGFloat?
    
    let closeButton = CloseButtonCustom()
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
    var textView: UITextView?

    // MARK: - Setup Functions
    
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
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        imageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        imageView.image = data.coverImage
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
        let string = data.title
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        titleLabel.attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let minimumLineSpacing: CGFloat = 100
        layout.minimumLineSpacing = minimumLineSpacing
        let minimumInteritemSpacing: CGFloat = 8
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        let itemSizeWidth = 80
        let itemSizeHeight = 80
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(DrawingCollectionViewCell.self, forCellWithReuseIdentifier: DrawingCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor , constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupTextView() {
        guard let data = data else {return}
        textView = UITextView()
        guard let textView = textView else {
            return
        }
        textView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        
        textView.text = data.text
        textView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textView.font = UIFont(name: "Rockwell-Regular", size: 24)
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        textView.textContainer.heightTracksTextView = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        guard let collectionView = collectionView else {return}
        textView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        textView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
    }
    
    // MARK: - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {return 0}
        return data.paths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrawingCollectionViewCell.identifier, for: indexPath) as! DrawingCollectionViewCell
        cell.backgroundColor = .clear
        cell.state = self.state
        guard let state = state else {return cell}
        guard let data = data else {return cell}
        
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue         = 0.0
        animation.toValue           = 1.0
        animation.duration          = 3.0
        animation.repeatCount       = 0
        animation.autoreverses      = false
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
    cell.layer.add(animation, forKey: "strokeEnd")
        
        let notAnimation = CABasicAnimation(keyPath: "strokeEnd")
        notAnimation.fromValue         = 1.0
        notAnimation.toValue           = 1.0
        notAnimation.duration          = 3.0
        notAnimation.repeatCount       = 0
        notAnimation.autoreverses      = false
        notAnimation.isRemovedOnCompletion = false
        notAnimation.isAdditive = true
        notAnimation.fillMode = CAMediaTimingFillMode.forwards
    cell.layer.add(notAnimation, forKey: "strokeEnd")
    
        if state.isSwitchedOn{
        cell.animate(isSwitchedOn: state.isSwitchedOn, path: data.paths[indexPath.row],animation: animation)
        } else {
            cell.animate(isSwitchedOn: state.isSwitchedOn, path: data.paths[indexPath.row],animation: notAnimation)
        }
        return cell
    }
    
}

