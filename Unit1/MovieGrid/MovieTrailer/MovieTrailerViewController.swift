//
//  MovieTrailerViewController.swift
//  Unit1
//
//  Created by Sheryl Seeyave on 3/4/22.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {


    @IBOutlet weak var trailerWebView: WKWebView!
    var key: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.youtube.com/watch?v=\(key!)")
        let myRequest = URLRequest(url: myURL!)
        trailerWebView.load(myRequest)
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
