import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var meals: [Meal] = []
    var filteredMeals: [Meal] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        searchMealByName(name: "")
        setupConstraints()
    }
    func setupConstraints() {
            // Activate Auto Layout constraints programmatically
            tableView.translatesAutoresizingMaskIntoConstraints = false
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            
            // Add tableView constraints
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            // Add searchBar constraints
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    func didSelectEndpoint(_ endpoint: String) {
            fetchData(for: endpoint)
        }
        
        func fetchData(for endpoint: String) {
            MealAPI.shared.fetchData(for: endpoint) { result in
                switch result {
                case .success(let meals):
                    self.meals = meals
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    func searchMealByName(name: String) {
        MealAPI.shared.searchMealByName(name: name) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.filteredMeals = meals
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMeals.count : meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = isSearching ? filteredMeals[indexPath.row] : meals[indexPath.row]
        cell.textLabel?.text = meal.strMeal
        cell.detailTextLabel?.text = meal.strCategory
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = isSearching ? filteredMeals[indexPath.row] : meals[indexPath.row]
        showMealDetail(for: selectedMeal)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredMeals = meals
        } else {
            isSearching = true
            filteredMeals = meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

extension ViewController {
    func showMealDetail(for meal: Meal) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mealDetailVC = storyboard.instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController {
            mealDetailVC.meal = meal
            navigationController?.pushViewController(mealDetailVC, animated: true)
        }
    }
}
