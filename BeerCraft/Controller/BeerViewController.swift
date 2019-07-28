//
//  BeerViewController.swift
//  BeerCraft
//
//  Created by ARY@N on 28/07/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import ProgressHUD

protocol cart{
    func item(title: String)
}

class BeerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    var delegate: cart?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    var data: [BeerModel] = []
    let beerModel = BeerModel()
    var BeerData: Results<BeerDB>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BeerData = realm.objects(BeerDB.self)
        if BeerData?.isEmpty == true{
            fetch()
        }else{
            collectionView.reloadData()
        }

        
    }
    @IBAction func cartButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }
   
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        cartButton.title = "Cart \(Int(sender.value).description)"
        delegate?.item(title: Int(sender.value).description)
        ProgressHUD.showSuccess("Added to Cart")
    }
    //MARK- Api fetch using Alamofire
    func fetch(){
        Alamofire.request("http://starlord.hackerearth.com/beercraft", method: .get).responseJSON { (response) in
            
            if response.result.isSuccess{
                print("Successfully got the data")
                let json = JSON(response.result.value!)
                json.array?.forEach({ (respond) in
                    self.beerModel.abv = respond["abv"].stringValue
                    self.beerModel.id = respond["id"].intValue
                    self.beerModel.name = respond["name"].stringValue
                    self.beerModel.Style = respond["style"].stringValue
                    self.beerModel.Ounces = respond["ounces"].intValue
                    self.data.append(self.beerModel)
                    self.saveToDatabase(data: self.beerModel)
                })
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    //MARK- Data saved to database
    private func saveToDatabase(data: BeerModel){
        
        try! realm.write {
            let responds = BeerDB()
            responds.Abv = data.abv
            responds.ID = data.id
            responds.Name = data.name
            responds.Style = data.Style
            responds.Ounces = data.Ounces
            realm.add(responds)
        }
        collectionView.reloadData()
    }
    func loadItems(){
        BeerData = selectedCategory?.beer.sorted(byKeyPath: "Name", ascending: true)
        collectionView.reloadData()
    }
}
//MARK- Collection view delegate,datasource method
extension BeerViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Added to cart")
        delegate?.item(title: BeerData?[indexPath.row].Name ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if BeerData!.isEmpty{
           return data.count
        }else{
            return BeerData?.count ?? 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCell", for: indexPath) as! BeerCollectionCell
        cellLayer(cellType: cell)
        if BeerData?.isEmpty == true{
            let index = self.data[indexPath.item]
            cell.titleLabel.text = index.name
            cell.styleLabel.text  = index.Style
            cell.ounceLabel.text = "Alcohol Content: \(index.abv)"
            cell.stepper.wraps = true
            cell.stepper.autorepeat = true
            cell.stepper.maximumValue = 10
            return cell
        }else{
            cell.titleLabel.text = BeerData?[indexPath.row].Name
            cell.styleLabel.text = BeerData?[indexPath.row].Style
            cell.ounceLabel.text = "Alcohol Content: \(BeerData?[indexPath.row].Abv ?? "0")"
           // delegate?.item(title: (BeerData?[indexPath.row].Name)!)
            cell.stepper.wraps = true
            cell.stepper.autorepeat = true
            cell.stepper.maximumValue = 10
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        return CGSize(width: width-30, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15 , left: 15, bottom: 15, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        delegate?.item(title: BeerData?[indexPath.row].Name ?? "")
    }
    //MARK- Sort the collection view
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        let tmp = data.remove(at: indexPath.item)
        data.insert(tmp, at: indexPath.item)
        return true
    }
}
//MARK- Search Bar delegate method
extension BeerViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        BeerData = BeerData?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "Name",ascending: true)
        collectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
