//
//  MovieDetailsViewController.swift
//  flixter
//
//  Created by Emira Hajj on 9/26/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import AlamofireImage

class MovieDetailsViewController: UIViewController, YTPlayerViewDelegate {
    
    var movie: [String:Any]!
    
    var videoStuff = [[String:Any]]()
    var YTlink: String!
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var invisibleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.delegate = self
        
        titleLabel.text = movie["title"] as? String
        
        synopsisLabel.text = movie["overview"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af_setImage(withURL: backdropUrl!)
        //print(movie)
        posterView.isUserInteractionEnabled = true
        
        let x = movie["id"] as! Int
        let ID = String(x)
        
        let finalUrl = URL(string: "https://api.themoviedb.org/3/movie/" + ID + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: finalUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print(dataDictionary)
                
                self.videoStuff = dataDictionary["results"] as! [[String:Any]]
                //print(self.videoStuff)
                let vidinfo = self.videoStuff.first!
                //print(vidinfo)
                let ytPath = vidinfo["key"] as! String
                //print(ytPath)
                //self.YTlink = "https://www.youtube.com/watch?v=/" + ytPath
                self.playerView.load(withVideoId: ytPath)

                
            }
        }
        task.resume()
        posterView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
        posterView.layer.borderWidth = 2
        
        
        


        // Do any additional setup after loading the view.
        
        
        
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .clear
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ensuring the sender is the type of cell we want
        //_ = sender as! UIButton
        
        //getting the index of the movie that lives in the table view
        //indexPath stores the row and section that something lives in
        
        
        let trailerViewController =  segue.destination as! trailerViewController
        
        let x = movie["id"] as! Int
        let ID = String(x)
        
        //setting the movie variable in the MovieDetailsViewController file to the movie we just extracted
        trailerViewController.movieID = ID
        
     
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
