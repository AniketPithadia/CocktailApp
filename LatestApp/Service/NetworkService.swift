//
//  NetworkService.swift
//  LatestApp
//
//  Created by Aniket Pithadia on 19/04/24.
//



import Foundation

protocol NetworkingCocktailDelegate {
    func networkingDidFinishWithCocktailList(cockTailList: [Cocktail])
    func networkingDidFinishWithError()
}
protocol NetworkingCocktailDetailDelegate {
    func networkingDidFinishWithCocktailDetails(cocktailDetail : CocktailDetail)
    func networkingDidFinishWithError()
}

class NetworkingService {
    
    static var shared = NetworkingService()
    
    var cocktailDelegate : NetworkingCocktailDelegate?
    var cocktailDetailDelegate : NetworkingCocktailDetailDelegate?
    
    func getListOfCocktails(searchText: String){
        print("INSIDE HERE")
        let urlObj = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="+searchText)!
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            
            if error != nil {
                self.cocktailDelegate?.networkingDidFinishWithError()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.cocktailDelegate?.networkingDidFinishWithError()
                return
            }
            
            
            do{
                
                let decoder = JSONDecoder()
                let result = try decoder.decode(CocktailResult.self, from: data!)
                print(result.drinks)
                DispatchQueue.main.async {
                    self.cocktailDelegate?.networkingDidFinishWithCocktailList(cockTailList: result.drinks )
                }
                
            }
            catch{
                print(error)
                
            }
            
            
        }
        
        task.resume()
    }
    
    func getCocktailDetails(id: String) {
            let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
            guard let url = URL(string: urlString) else {
                self.cocktailDetailDelegate?.networkingDidFinishWithError()
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    self.cocktailDetailDelegate?.networkingDidFinishWithError()
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CocktailDetailResult.self, from: data)
                    print(result.drinks)
                    if let cocktail = result.drinks.first {
                        self.cocktailDetailDelegate?.networkingDidFinishWithCocktailDetails(cocktailDetail: cocktail)
                    } else {
                        self.cocktailDetailDelegate?.networkingDidFinishWithError()
                    }
                } catch {
                    self.cocktailDetailDelegate?.networkingDidFinishWithError()
                }
            }
            
            task.resume()
        }

}
