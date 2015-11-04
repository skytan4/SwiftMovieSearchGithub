//
//  DetailViewController.swift
//  SwiftMovieSearch
//
//  Created by Skyler Tanner on 11/4/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            self.updateWithMovie(movie)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithMovie(movie: Movie) {
        self.titleLabel.text = movie.title
        self.yearLabel.text = movie.year
    }

}
