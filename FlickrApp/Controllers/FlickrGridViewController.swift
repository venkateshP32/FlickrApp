//
//  FlickrGridViewController.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//

import UIKit

class FlickrGridViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var gridFlowLayout = FlickrGridLayout()
    
    var flickerResultsArray: FlickerResults?
    
    var flickerItemsArray: [FlickerItem] = [FlickerItem]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = gridFlowLayout
    }
    
    func updateUI() {
        let layout = gridFlowLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    func createAPIRequest(searchString: String) {
        
        guard let urlStr =  URL(string: "\(flickr_feed)?format=json&nojsoncallback=1&tags=\(searchString)") else {
            return
        }
        fetchAPIDetailsForSearch(searchString: urlStr)
    }
    
    func fetchAPIDetailsForSearch(searchString: URL) {
        loadingIndicator.startAnimating()
        URLSession.shared.dataTask(with: searchString ) {( data,response, error) in
            
            guard let data = data, error == nil else {return}
            
            var results: FlickerResults?
            // convert the data to json object
            do {
                results = try JSONDecoder().decode(FlickerResults.self, from: data)
            } catch {
                print("error:\(error)")
            }
            
            guard let flickerResults = results?.items else { return }
            
            self.flickerItemsArray.removeAll()
            
            self.flickerItemsArray.append(contentsOf: flickerResults)
            
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
            
        }.resume()
    }
    
    func showDetails(item: FlickerItem) {
        
        guard let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FlickrDetailsViewController.self)) as? FlickrDetailsViewController else {
            return
        }
        detailsVC.detailsItem = item
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension FlickrGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickerItemsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FlickrGridCollectionCell.self), for: indexPath) as! FlickrGridCollectionCell
        
        let index = indexPath.row % flickerItemsArray.count
        guard let imageName = flickerItemsArray[index].media?.imageLink else { return cell }
        cell.loadImage(imageUrl: imageName)
        return cell
        
    }
}

extension FlickrGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(item: flickerItemsArray[indexPath.row])
    }
}

extension FlickrGridViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, searchText.count > 3 else {
            return
        }
        createAPIRequest(searchString: searchText)
    }
    
}
