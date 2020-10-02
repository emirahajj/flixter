//
//  MovieDetailsViewController.swift
//  flixter
//
//  Created by Emira Hajj on 9/26/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var invisibleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        // Do any additional setup after loading the view.
        
        
        
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
