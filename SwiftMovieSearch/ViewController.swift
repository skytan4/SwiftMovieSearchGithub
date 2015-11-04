//
//  ViewController.swift
//  SwiftMovieSearch
//
//  Created by Skyler Tanner on 10/29/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableVIew: UITableView!
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.movies = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.movies = []
        self.tableVIew.reloadData()
        searchBar.text = ""
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkController.searchMovies(searchText) { (movies, error) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let movies = movies {
                    self.movies = movies
                } 
                self.tableVIew.reloadData()
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.movies.count == 0 {
            return 1
        } else {
            return self.movies.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as UITableViewCell
        
        if self.movies.count == 0 {
            cell.textLabel?.text = "No Results Found"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else{
            cell.selectionStyle = UITableViewCellSelectionStyle.Default
            let movie = self.movies[indexPath.row]
            cell.textLabel?.text = movie.title
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue"{
            if self.movies.count == 0 {
                
            } else {
                let detailView = segue.destinationViewController as! DetailViewController
                let index = self.tableVIew.indexPathForSelectedRow
                if let index = index {
                    detailView.movie = self.movies[index.row]
                }
            }
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "detailSegue"{
            if self.movies.count == 0 {
                return false
            } else {
                return true
            }
        }
        else {
            return true
        }
    }
}


