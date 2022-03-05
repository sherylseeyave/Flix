//
//  MovieGridDetailViewController.swift
//  Unit1
//
//  Created by Sheryl Seeyave on 2/26/22.
//

import UIKit
import Alamofire

class MovieGridDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)

        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        posterView.af_setImage(withURL: posterUrl!)
        backdropView.af_setImage(withURL: backdropUrl!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(posterTap(_:)))
        
         // Optionally set the number of required taps, e.g., 2 for a double click
         tapGestureRecognizer.numberOfTapsRequired = 1

         // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
         posterView.isUserInteractionEnabled = true
         posterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func posterTap(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: view)
        
        performSegue(withIdentifier: "trailerTitleSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerTitleViewController = segue.destination as! MovieTrailerTitleViewController
        trailerTitleViewController.movieID = movie["id"] as? Int
        
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
