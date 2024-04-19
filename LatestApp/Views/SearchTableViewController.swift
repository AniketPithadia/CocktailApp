//
//  SearchTableViewController.swift
//  LatestApp
//
//  Created by Aniket Pithadia on 19/04/24.
//

import UIKit

class SearchTableViewController: UITableViewController,UISearchBarDelegate,NetworkingCocktailDelegate {
    
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        NetworkingService.shared.cocktailDelegate = self

    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate?.cocktailList.count ?? 0
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            NetworkingService.shared.getListOfCocktails(searchText: searchText)
        }
        if searchText.count == 0 {
            appDelegate?.cocktailList = []
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let drink = appDelegate?.cocktailList[indexPath.row] {
            cell.textLabel?.text = drink.strDrink
        } else {
            cell.textLabel?.text = "Unknown"
        }
        return cell
    
    }
    func networkingDidFinishWithCocktailList(cockTailList: [Cocktail]) {
        appDelegate?.cocktailList = cockTailList
        tableView.reloadData()
        
    }
    
    func networkingDidFinishWithError() {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let indext = tableView.indexPathForSelectedRow!.row
        let dvc = segue.destination as? CocktailDetailViewController
        dvc?.cocktail = (appDelegate?.cocktailList[indext])!
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
