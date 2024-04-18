//
//  MealDetailViewController.swift
//  finalproj2
//
//  Created by Dumindu Harshana on 2024-04-17.
//
import CoreData
import UIKit

class MealDetailViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext!
    var meal: Meal?
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealInstructionsLabel: UILabel!
    
    
        override func viewDidLoad() {
                super.viewDidLoad()
                
                // Check if meal object exists
                guard let meal = meal else {
                    return
                }
            
                
                // Populate UI elements with meal details
                mealNameLabel.text = meal.strMeal
                mealCategoryLabel.text = meal.strCategory
                mealInstructionsLabel.text = meal.strInstructions
                
                if let imageUrl = URL(string: meal.strMealThumb) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageUrl) {
                            DispatchQueue.main.async {
                                self.mealImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
    
               
             
    @IBAction func saveButtonTapped(_ sender: UIButton) {
           guard let meal = meal else {
               return
           }
           
           // Save meal details to Core Data
           saveMealToCoreData(meal)
       }
       
                   
               
               func saveMealToCoreData(_ meal: Meal) {
                   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                       return
                   }
                   let context = appDelegate.persistentContainer.viewContext
                   
                   let entity = NSEntityDescription.entity(forEntityName: "SavedMeal", in: context)!
                   let savedMeal = NSManagedObject(entity: entity, insertInto: context)
                   savedMeal.setValue(meal.strMeal, forKey: "name")
                   savedMeal.setValue(meal.strCategory, forKey: "category")
                   savedMeal.setValue(meal.strInstructions, forKey: "instructions")
                   savedMeal.setValue(meal.strMealThumb, forKey: "imageURL")
                   
                   do {
                       try context.save()
                       // Show alert after saving
                       let alert = UIAlertController(title: "Saved", message: "Meal details saved successfully.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       present(alert, animated: true, completion: nil)
                   } catch {
                       print("Failed to save meal details:", error)
                   }
               }
           }
