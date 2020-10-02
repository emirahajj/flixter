//
//  trailerViewController.swift
//  flixter
//
//  Created by Emira Hajj on 10/1/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class trailerViewController: UIViewController {
    
    var movieID: String!
    var videoStuff = [[String:Any]]()
    var YTlink: String!
    
    @IBOutlet var playerView : YTPlayerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = self
        //tableView.delegate = self
        
        let finalUrl = URL(string: "https://api.themoviedb.org/3/movie/" + movieID + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
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
                print(self.videoStuff)
                let vidinfo = self.videoStuff.first!
                print(vidinfo)
                let ytPath = vidinfo["key"] as! String
                print(ytPath)
                //self.YTlink = "https://www.youtube.com/watch?v=/" + ytPath
                self.playerView.load(withVideoId: ytPath)
                
            }
        }
        task.resume()

        // Do any additional setup after loading the view.
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
