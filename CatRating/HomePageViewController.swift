//
//  HomePageViewController.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
    @IBAction func rateCatsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "RatingSegue", sender: self)
    }
    @IBAction func ratedCatsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "RatingListSegue", sender: self)
        
    }
    @IBAction func cinematicModeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "CinematicSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
