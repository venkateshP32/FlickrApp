//
//  FlickrGridCollectionCell.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//

import UIKit
class FlickrGridCollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 3
        cardView.layer.masksToBounds = true
    }
    
    func loadImage(imageUrl: String) {
            let imageCache = NSCache<AnyObject ,AnyObject>()
            
            guard let urlstring = URL(string: imageUrl) else { return }
            
            
            if let image = imageCache.object(forKey: urlstring.absoluteString as NSString) as? UIImage {
                self.imageView.image = image
                return
            }
            
            URLSession.shared.dataTask(with: urlstring) {(data, response, error) in
                guard let Data = data else {
                    return
                }
                
                if let image = UIImage(data: Data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlstring.absoluteString as NSString)
                        self.imageView.image = image
                    }
                }
            }.resume()
        }

}
