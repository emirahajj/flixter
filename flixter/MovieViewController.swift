//
//  MovieViewController.swift
//  flixter
//
//  Created by Emira Hajj on 9/19/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    

    //instatiating the array of dictionaries
    var movies=[[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                self.tableView.reloadData()
            }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    //for this particular row, give me the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //what this does is "recycle" the cells that are not visible so we don't run out of memory
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        //gets called 50 times, or as many times as the number returned in previous function
        cell.titleLabel.text = title
        cell.SynopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    //leaving the curent screen-you "prepare" the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //first find the selected movie --sender is the cell that is passed over
        
        //ensuring the sender is the type of cell we want
        let cell = sender as! UITableViewCell
        
        //getting the index of the movie that lives in the table view
        //indexPath stores the row and section that something lives in
        let indexPath = tableView.indexPath(for: cell)!
        
        //movie now eauals the
        let movie = movies[indexPath.row]
        
        
        let detailsViewController =  segue.destination as! MovieDetailsViewController
        
        //setting the movie variable in the MovieDetailsViewController file to the movie we just extracted
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //then pass the selected movie to the details view controller
        
    }
    

}
