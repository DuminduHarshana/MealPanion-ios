import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var searchByNameButton: UIButton!
    @IBOutlet weak var listByFirstLetterButton: UIButton!
    @IBOutlet weak var listAllCategoriesButton: UIButton!
    @IBOutlet weak var lookupRandomMealButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchByNameButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func listByFirstLetterButtonTapped(_ sender: UIButton) {
        // Handle list by first letter button tap
    }

    @IBAction func listAllCategoriesButtonTapped(_ sender: UIButton) {
        // Handle list all categories button tap
    }

    @IBAction func lookupRandomMealButtonTapped(_ sender: UIButton) {
        // Handle lookup random meal button tap
    }
}

