//
//  MealDetailsViewController.swift
//  MajelanTest
//
//  Created by Florian DERONE on 27/05/2020.
//  Copyright © 2020 Florian DERONE. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myLabel: UILabel!
}

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealTagsCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealCategoryImage: UIImageView!
    @IBOutlet weak var mealInstructions: UITextView!
    @IBOutlet weak var mealView: UIView!
    @IBOutlet weak var btnMealSource: UIButton!
    @IBOutlet weak var btnMealYoutube: UIButton!
    @IBOutlet weak var lineSeparatorView: UIView!
    
    public var meal : Meals?
    
    private var tags : [String] = []
    private var category : String?
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

        guard meal != nil else { return }
        
        self.initTagsList()
        
        self.category = meal!.category
        mealCategoryImage.image = getCategoryImage(meal!.category ?? "")
        mealView.backgroundColor = getCategoryColor(self.category ?? "")
        lineSeparatorView.backgroundColor = getCategoryColor(self.category ?? "")
        mealTitle.text = meal!.meal ?? ""
        mealInstructions.text = meal!.instructions ?? ""
        
        if let urlString = meal!.mealThumb {
            _ = mealImage.downloaded(from: "\(urlString)/preview")
        }
        
        if meal!.source == nil { btnMealSource.isEnabled = false }
        else {
            if let _ = URL(string: meal!.source!) {
                btnMealSource.isEnabled = true
            } else { btnMealSource.isEnabled = false }
        }
        
        if meal!.youtube == nil { btnMealYoutube.isEnabled = false }
        else { btnMealYoutube.isEnabled = true }
        
    }
    
    ///
    /// This function is used to generate the tags list of meal
    ///
    private func initTagsList() {
        
        if meal!.tags != nil {
            self.tags = meal!.tags!.components(separatedBy: ",")
            mealTagsCollectionView.reloadData()
        } else { mealTagsCollectionView.isHidden = true }
        
    }
    
    @IBAction func pressSourceButton(_ sender: Any) {
        guard meal != nil else { return }
        guard meal!.source != nil else { return }
        guard let url = URL(string: meal!.source!) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func pressYoutubeButton(_ sender: Any) {
        guard meal != nil else { return }
        guard meal!.youtube != nil else { return }
        UIApplication.shared.open(meal!.youtube!)
    }
    
}

extension MealDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard meal != nil else { return 0 }
        guard meal!.ingredients != nil else { return 0 }
        return meal!.ingredients!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        
        guard meal != nil else { return UITableViewCell() }
        guard meal!.ingredients != nil else { return UITableViewCell() }
        guard meal!.measures != nil else { return UITableViewCell() }
        
        cell.textLabel?.text = meal!.ingredients![indexPath.row]
        cell.detailTextLabel?.text = meal!.measures![indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
}

extension MealDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource Protocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MyCollectionViewCell

        cell.myLabel.text = "  \(self.tags[indexPath.item])  "
        cell.backgroundColor = getCategoryColor(self.category ?? "")
        
        // "Lamb" color is approximatively white... set text color to black"
        cell.myLabel.textColor = (meal!.category == "Lamb") ? .black : .white

        return cell
    }
    
}
