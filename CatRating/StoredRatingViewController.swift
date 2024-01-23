//
//  StoredRatingViewController.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import UIKit

class StoredRatingViewController: UIViewController {

    var ratng:rating?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = ratng!.name
        self.commentLabel.text = ratng!.comment
        self.dateLabel.text = "date: " + ratng!.date.formatted()
        self.ratingLabel.text = "rating: " + String(ratng!.rating)
        self.imageView.image = ratng!.image
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
