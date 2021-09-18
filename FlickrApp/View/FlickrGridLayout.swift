//
//  FlickrGridLayout.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//


import UIKit

class FlickrGridLayout: UICollectionViewFlowLayout {
        
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    var itemWidth: CGFloat {
        return collectionView!.frame.width / 2 - 10
    }
    
    var itemHeight : CGFloat{
        return itemWidth
    }
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
            
        }
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
