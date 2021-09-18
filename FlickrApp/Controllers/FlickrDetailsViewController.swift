//
//  FlickrDetailsViewController.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//

import UIKit

class FlickrDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var imageDetails: UILabel!
    
    var detailsItem: FlickerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        if let desc = detailsItem?.description {
            descriptionText.text = desc.html2AttributedString
        }
        self.title = detailsItem?.title
        
        let imageCache = NSCache<AnyObject ,AnyObject>()

        if let imageName = detailsItem?.media?.imageLink, let key = URL(string: imageName)?.absoluteString {
            if let image = imageCache.object(forKey: key as NSString) as? UIImage {
               detailsImageView.image = image
                self.imageDetails.text = "Image Details:\nWidth: \(image.size.width)\nHeight: \(image.size.height)"

            } else {
                if let url = URL(string: imageName) {
                    URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let Data = data else {
                            return
                        }
                        
                        if let image = UIImage(data: Data) {
                            DispatchQueue.main.async {
                                imageCache.setObject(image, forKey: key as NSString)
                                self.detailsImageView.image = image
                                self.imageDetails.text = "Image Details:\nWidth: \(image.size.width)\nHeight: \(image.size.height)"
                            }
                        }
                    }.resume()
                }
            }
        }
    }

    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

