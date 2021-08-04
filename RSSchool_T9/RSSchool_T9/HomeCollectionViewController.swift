//
//  HomeCollectionViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

class HomeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let state = PaintingState()
    
    let data = FillingData.data

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureCollectionView()
        
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let minimumLineSpacing: CGFloat = 30
        layout.minimumLineSpacing = minimumLineSpacing
        let minimumInteritemSpacing: CGFloat = 8
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        let itemSizeWidth = (UIScreen.main.bounds.width-40-minimumInteritemSpacing*2)/2
        let itemSizeHeight = itemSizeWidth * 1.23
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {return}
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

    }
    
// --MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        
        switch data[indexPath.row] {
        case .story(let data):
            cell.configure(typeLabelText: data.title, titleLabelText: data.type, image: data.coverImage)
        case .gallery(let data):
            cell.configure(typeLabelText: data.title, titleLabelText: data.type, image: data.coverImage)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case .story(let data):
            let storyVC = StoryViewController()
            storyVC.state = self.state
            storyVC.data = data
            storyVC.isModalInPresentation = true
            storyVC.modalPresentationStyle = .fullScreen
            self.present(storyVC, animated: true, completion: nil)
        case .gallery(let data):
            let galleryVC = GalleryViewController()
            galleryVC.data = data
            galleryVC.isModalInPresentation = true
            galleryVC.modalPresentationStyle = .fullScreen
            self.present(galleryVC, animated: true, completion: nil)
        }
    }

}
