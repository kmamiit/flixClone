//
//  Movie.swift
//  flixClone
//
//  Created by Kyle Mamiit (New) on 11/5/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterURL: URL?
    var backdropURL: URL?
    var overview: String
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        overview = dictionary["overview"] as? String ?? "No overview"
        
        let posterPathString = dictionary["poster_path"] as? String ?? "No poster path"
        let backdropPathString = dictionary["backdrop_path"] as? String ?? "No backdrop path"
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        posterURL = URL(string: baseURLString + posterPathString )!
        //print(posterURL)
        print("baseURL: " + baseURLString as String)
        print("backdrop: " + backdropPathString as String)
        
        let backdropPath = dictionary["backdrop_path"]
        print(backdropPath)
        print("BACKDROP_PATH_STRING: " + backdropPathString)
        if let backdropPath = backdropPath {
            print(backdropPath)
            //backdropURL = URL(string: baseURLString + backdropPathString)!
            if backdropPathString == "No backdrop path"{  // Some movies don't have backdrop
                backdropURL = URL(string: baseURLString + posterPathString)!
            } else {
                backdropURL = URL(string: baseURLString + backdropPathString)!
            }
        } else {
            print("THIS")
        }
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
    
}



