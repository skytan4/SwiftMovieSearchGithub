//
//  NetworkController.swift
//  SwiftMovieSearch
//
//  Created by Skyler Tanner on 10/29/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation
class NetworkController {

    static func searchMovies(searchString: String, callback: ([Movie]?, NSError?) -> ()) {
        
        let termStringFixed = searchString.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let stringUrl = "https://www.omdbapi.com/?s=\(termStringFixed)&y=&plot=short&r=json"
        
        if let url = NSURL(string: stringUrl) {
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithURL(url) {(data, response, error) -> Void in
                if let error = error {
                    callback(nil, error)
                    return
                }
                guard let data = data else {
                    callback(nil,nil)
                    print("Error getting data")
                    return
                }
                
                let jsonObject: AnyObject
                
                do{
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                } catch(let error as NSError) {
                    callback(nil, error)
                    return
                }
                
                if let searchObject = jsonObject as? [String: [AnyObject]],
                    let movieArray = searchObject["Search"] {
                        
                        var movieObjects: [Movie] = []
                        
                        movieArray.forEach({ (jsonMovie) -> () in
                            if let movieObject = Movie(data: jsonMovie) {
                                movieObjects.append(movieObject)
                            }
                        })
                        callback(movieObjects, nil)
                } else {
                    callback(nil,nil)
                }
                print(jsonObject)
            }
            dataTask.resume()
        }
       
    }
}