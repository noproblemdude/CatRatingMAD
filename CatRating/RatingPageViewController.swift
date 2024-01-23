//
//  RatingPageViewController.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import UIKit
import CoreData

class RatingPageViewController: UIViewController {
    
    let netwk = networking()
    let dataMngr = dataManager()
    
    @IBAction func newImageButton(_ sender: Any) {
        loadPicture()
    }
    @IBAction func rateCatButton(_ sender: Any) {
        dataMngr.saveRating(name: nameField.text!,comment: commentField.text!,rating: Int(ratingField.text!)!,image: self.imageView.image!)
    }
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var cinematicImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(cinematicImage == nil){
            loadPicture()
        }else{
            self.imageView.image = cinematicImage!
        }
        
        
    }
    
    func loadPicture(){
        netwk.getCatPic(CompletionHandler: comphand)
    }
    
    func comphand(data: Data?){
        
        DispatchQueue.main.sync{
            self.imageView.image = UIImage(data: data!)
        }
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
