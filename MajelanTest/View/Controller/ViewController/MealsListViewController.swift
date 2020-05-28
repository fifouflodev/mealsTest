//
//  MealsListViewController.swift
//  MajelanTest
//
//  Created by Florian DERONE on 27/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import UIKit

class MealsListViewController: UIViewController {

    let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
    @IBOutlet weak var seachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var sortedMealsList : [(String, [Meals])] = []
    var filteredMealsList : [(String, [Meals])] = []
    
    private var selectedMeal: Meals = Meals()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        attemptToFetchAllMeals()
    }
    
    ///
    /// This function is used to initiate the fetching process
    ///
    private func attemptToFetchAllMeals() {
        
        self.myAppDelegate.mealsVM.fetchAllMeals()
        
        self.myAppDelegate.mealsVM.didFinishFetchAllMeals = {
            self.sortMealsAndCategory()
            self.tableView.reloadData()
        }
        
    }
    
    ///
    /// This function is used to sort the row and section into the tableview
    ///
    private func sortMealsAndCategory() {
        
        let mealDictionary = Dictionary(grouping: self.myAppDelegate.mealsVM.meals, by: { $0.category! })
        let categoryList = [String](Array(mealDictionary.keys).sorted(by:<))
        
        for category in categoryList {
            
            var mealsList : [Meals] = []
            
            for meal in self.myAppDelegate.mealsVM.meals {
                if meal.category == category {
                    mealsList.append(meal)
                }
            }
            
            self.sortedMealsList.append((category, mealsList))
        }
        
        self.filteredMealsList = self.sortedMealsList
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mealDetailSegue" {
            if let newVC = segue.destination as? MealDetailsViewController {
                newVC.meal = self.selectedMeal
            }
        }
    }
    
}

extension MealsListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMealsList[section].1.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.filteredMealsList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let view = tableView.dequeueReusableHeaderFooterView(
                            withIdentifier: SectionHeaderView.reuseIdentifier)
                            as? SectionHeaderView
        else { return nil }

        let category = self.filteredMealsList[section].0
        
        view.textLabel?.text = category
        view.imageView?.image = getCategoryImage(category)
        view.view.backgroundColor = getCategoryColor(category)

        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealsCell", for: indexPath) as! AllMealsTableViewCell
        
        let meal = self.filteredMealsList[indexPath.section].1[indexPath.row]
        
        cell.mealsTitle.text = meal.meal ?? ""
        cell.mealsImageArea.image = getAreaFlag(area: meal.area ?? "")
        
        if let urlString = meal.mealThumb {
            _ = cell.mealsImage.downloaded(from: "\(urlString)/preview", contentMode: .scaleAspectFill)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedMeal = self.filteredMealsList[indexPath.section].1[indexPath.row]
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "mealDetailSegue", sender: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
}

extension MealsListViewController : UISearchBarDelegate {
    
    //
    // This method updates filteredData based on the text in the Search Box
    //
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty { self.filteredMealsList = self.sortedMealsList }
        else {
            self.filteredMealsList.removeAll(keepingCapacity: false)
            
            for mealList in self.sortedMealsList {
                
                var meals : [Meals] = []
                
                for meal in mealList.1 {
                    if meal.meal!.lowercased().contains(searchText.lowercased()) { meals.append(meal) }
                }
    
                self.filteredMealsList.append((mealList.0, meals))
            }
            
        }
        
        /// Remove the empty section
        self.filteredMealsList = self.filteredMealsList.filter { $0.1.count != 0 }
        
        tableView.reloadData()
        
    }
    
}
