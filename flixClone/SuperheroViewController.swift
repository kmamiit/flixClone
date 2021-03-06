//
//  SuperheroViewController.swift
//  flixClone
//
//  Created by Kyle Mamiit (New) on 10/14/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        //let width = collectionView.frame.size.width
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        fetchMovies()
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.movie = movies[indexPath.item]
 
        return cell
    }

    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
    }
    
//    func fetchMovies(){
//        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b631d5e2369b670b3dc2380dd94a6089")!
//
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//            // This will run when a network request returns
//            if let error = error {
//                print(error.localizedDescription)
//
//                let alertController = UIAlertController(title: "Can't Load Movies", message: "Please make sure you are connected to the internet", preferredStyle: .alert)
//
//                let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) in
//                    print("Alert Initiated")
//                })
//
//                alertController.addAction(OKAction)
//
//                DispatchQueue.main.async {
//                    self.present(alertController, animated: true, completion: nil)
//                }
//
//            } else if let data = data {
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let movies = dataDictionary["results"] as! [[String: Any]]
//                self.movies = movies
//                self.collectionView.reloadData()
//                //self.refreshControl.endRefreshing()
//            }
//        }
//        task.resume()
//        //activityIndicator.stopAnimating()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
