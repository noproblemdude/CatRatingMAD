
import Foundation
import CoreData
import UIKit

class dataManager{
    
    let appDelegate:AppDelegate
    let context: NSManagedObjectContext
    let entityName: String
    let request: NSFetchRequest<NSFetchRequestResult>
    
    init() {
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        self.entityName = "CDRating"
        self.request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        
    }
    
    func saveRating(name: String,comment: String,rating: Int, image: UIImage){
        
        
        guard let newEntity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.context) else {return}
        
        let newRating = NSManagedObject(entity: newEntity, insertInto: self.context)
        
        let jpegImage = image.jpegData(compressionQuality: 1.0)
        
        newRating.setValue(name, forKey: "name")
        newRating.setValue(comment, forKey: "comment")
        newRating.setValue(rating, forKey: "rating")
        newRating.setValue(jpegImage, forKey: "image")
        newRating.setValue(Date(), forKey: "date")
        
        try! context.save()
    }
    
    func loadEverything()->[rating]{
        
        var output: [rating] = []
        
        do {
            let results = try self.context.fetch(self.request)
            
            
            for r in results {
                if let result = r as? NSManagedObject{
                    let name = result.value(forKey: "name") as? String
                    let comment = result.value(forKey: "comment") as? String
                    let rat = result.value(forKey: "rating") as? Int
                    let jpegImage = (result.value(forKey: "image") as? Data)!
                    let date = (result.value(forKey: "date") as? Date)!
                    
                    let image = UIImage(data: jpegImage)
                    
                    let rtng = rating(name: name!, rating: rat!, comment: comment!, image: image!,date: date)
                    print(rtng)
                    
                    output.append(rtng)
                    
                }
            }
            
        } catch{
            print(error)
        }
        
        return output
    }
    
    func deleteRating(index: Int){
         
        let results = try! self.context.fetch(self.request)
        
        let firstRating = results[index]
        
        context.delete(firstRating as! NSManagedObject)
        
        try! context.save()
        
    }
    
}

struct rating {
    var name:String
    var rating:Int
    var comment:String
    var image:UIImage
    var date:Date
}
