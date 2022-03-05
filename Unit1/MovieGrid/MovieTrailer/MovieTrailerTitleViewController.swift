//
//  MovieTrailerTitleViewController.swift
//  Unit1
//
//  Created by Sheryl Seeyave on 3/4/22.
//

import UIKit

class MovieTrailerTitleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var trailer = [[String:Any]]()
    var movieID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 self.trailer = dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()
             }
        }
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell") as! TrailerCell
        let trailer = trailer[indexPath.row]
        let title = trailer["name"] as! String
        
        cell.trailerTitle!.text = title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected trailer
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let trailer = trailer[indexPath.row]
        
        // Pass the selected trailer to the details view controller
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.key = trailer["key"] as? String
        print(trailerViewController.key!)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
