//
//  MovieGridViewController.swift
//  flixter
//
//  Created by Emira Hajj on 9/26/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2)/3
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                
                
                //reload data cuz upon opening up the movies.count is zero cuz data hasn't been fetched yet! this will return 0 for movies.count so selfForRowAt will not display anything
                self.collectionView.reloadData()

            }
        }
        task.resume()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //first find the selected movie --sender is the cell that is passed over
        
        //ensuring the sender is the type of cell we want
        let cell = sender as! UICollectionViewCell
        
        //getting the index of the movie that lives in the table view
        //indexPath stores the row and section that something lives in
        let indexPath = collectionView.indexPath(for: cell)!
        
        //movie now eauals the
        let movie = movies[indexPath.row]
        
        
        let heroDeetsViewController =  segue.destination as! MovieDetailsViewController
        
        //setting the movie variable in the MovieDetailsViewController file to the movie we just extracted
        heroDeetsViewController.movie = movie
        
        
        //then pass the selected movie to the details view controller
        
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
