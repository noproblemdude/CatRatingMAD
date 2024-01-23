//
//  RatingListViewController.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import UIKit

class RatingListViewController: UIViewController {

    var ratings:[rating] = []
    let dataMngr = dataManager()
   
    @IBOutlet weak var ratingListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ratings = dataMngr.loadEverything()
        ratingListTableView.delegate = self
        ratingListTableView.dataSource = self
        ratingListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let StoredRatingViewController = segue.destination as? StoredRatingViewController
            else{return}
        
        StoredRatingViewController.ratng = ratings[self.ratingListTableView.indexPathForSelectedRow![1]]
        
    }
    
}


extension RatingListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension RatingListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ratings[indexPath.row].name + "  " + ratings[indexPath.row].date.formatted()
        
        return cell
        
    }
    
}
