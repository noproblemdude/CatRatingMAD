//
//  CinematicViewController.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import UIKit

class CinematicViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        self.fullScreenImage()
    }
    
    @IBAction func rateCatButton(_ sender: Any) {
        self.performSegue(withIdentifier: "rateCatSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPicture()
        scheduledTimerWithTimeInterval()
        //imageView.addAgeSensitiveLabel()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let RatingPageViewController = segue.destination as? RatingPageViewController
            else{return}
        
        RatingPageViewController.cinematicImage = self.imageView.image
        
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    var newImageView = UIImageView()
    var imageText:String = ""
    let netwk = networking()
    var timer = Timer()
    
    func loadPicture(){
        netwk.getCatPic(CompletionHandler: comphand)
        netwk.getCatFact(CompletionHandler: factComphand)
    }
    
    func comphand(data: Data?){
        DispatchQueue.main.sync{
            self.imageView.image = UIImage(data: data!)
            self.newImageView.image = UIImage(data: data!)
        }
    }
    
    func factComphand(fact: catFact?){
        imageText = fact!.fact
    }
    
    func fullScreenImage(){
        self.newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        newImageView.addAgeSensitiveLabel(fact: self.imageText)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        netwk.getCatFact(CompletionHandler: factComphand)
        loadPicture()
        self.fullScreenImage()
    }
}

extension UIImageView {

    private func ageSensitiveLabel(fact : String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: self.bounds.height/2 - 50, width: self.bounds.width, height: self.bounds.height))
        label.text = fact
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = .white
        return label
    }

    func addAgeSensitiveLabel(fact: String) {
        self.subviews.forEach { view in
            DispatchQueue.main.async {
                view.removeFromSuperview()
            }
        }
        self.addSubview(ageSensitiveLabel(fact: fact))
    }
}
