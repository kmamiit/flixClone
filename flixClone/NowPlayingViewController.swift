//
//  NowPlayingViewController.swift
//  flixClone
//
//  Created by Kyle Mamiit (New) on 10/5/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        fetchMovies()
        //activityIndicator.stopAnimating()
    }

    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
        //activityIndicator.stopAnimating()
    }
    
    
    func fetchMovies(){
        activityIndicator.startAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b631d5e2369b670b3dc2380dd94a6089")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when a network request returns
            if let error = error {
                print(error.localizedDescription)
                
                let alertController = UIAlertController(title: "Can't Load Movies", message: "Please make sure you are connected to the internet", preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) in
                    print("Alert Initiated")
                })
                
                alertController.addAction(OKAction)
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        //activityIndicator.stopAnimating()
        task.resume()
        activityIndicator.stopAnimating()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! movieCell
        
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString )!
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        cell.selectionStyle = .none
        //Did this to customized the cell selection effect; thought this was reasonable because selecting a cell doesn't do anything yet
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
