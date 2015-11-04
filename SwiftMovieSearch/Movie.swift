//
//  Movie.swift
//  SwiftMovieSearch
//
//  Created by Skyler Tanner on 10/29/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation

struct Movie {
    
    var title: String
    var year: String
    var poster: String
    
    init?(data: AnyObject?) {
        guard let data = data as? [String: String] else { return nil }
        guard let title = data["Title"],
            let year = data["Year"],
            let poster = data["Poster"] else { return nil }
        
        self.title = title
        self.year = year
        self.poster = poster
    }
    
    
}