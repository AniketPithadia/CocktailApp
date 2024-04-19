//
//  CocktailDetailViewController.swift
//  LatestApp
//
//  Created by Aniket Pithadia on 19/04/24.
//

import UIKit

class CocktailDetailViewController: UIViewController,NetworkingCocktailDetailDelegate {
   
    @IBOutlet weak var cocktailThumbImg: UIImageView!
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var alcoholicLabel: UILabel!
    
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    @IBOutlet weak var instructionESLabel: UILabel!
    
    @IBOutlet weak var instructionDELabel: UILabel!
    
    var cocktail : Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.cocktailDetailDelegate = self
        if let cocktailId = cocktail?.idDrink as? String{
            NetworkingService.shared.getCocktailDetails(id: cocktailId)
        }
    }
    func networkingDidFinishWithCocktailDetails(cocktailDetail: CocktailDetail) {
        DispatchQueue.main.async {
                    self.updateUI(cocktailDetailObj: cocktailDetail)
                    if let url = URL(string: cocktailDetail.strDrinkThumb) {
                        self.downloadImage(from: url)
                    }
                }

        print(cocktailDetail)
    }
    
    func networkingDidFinishWithError() {
        
    }
    func updateUI(cocktailDetailObj : CocktailDetail){
        
        drinkLabel.text = cocktailDetailObj.strDrink
        categoryLabel.text = cocktailDetailObj.strCategory
        alcoholicLabel.text = cocktailDetailObj.strAlcoholic
        instructionsLabel.text = cocktailDetailObj.strInstructions
        instructionDELabel.text = cocktailDetailObj.strInstructionsDE
        instructionESLabel.text = cocktailDetailObj.strInstructionsES
    }

    func downloadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.cocktailThumbImg.image = UIImage(data: data)
                }
            }.resume()
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
