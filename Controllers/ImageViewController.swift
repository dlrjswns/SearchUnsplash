//
//  ImageViewController.swift
//  UnplashSearch
//
//  Created by 이건준 on 2021/10/24.
//

import UIKit

private let collectionCellIdentifier = "cell"
class ImageViewController:UICollectionViewController{
    let getImageItem:[ImageItem] = RootViewController.item

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
    }
}
extension ImageViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getImageItem.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! CollectionCell
        cell.imageURL = getImageItem[indexPath.row].image
        return cell
    }
}

extension ImageViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-2)/3, height: (view.frame.width-2)/3)
    }
}
