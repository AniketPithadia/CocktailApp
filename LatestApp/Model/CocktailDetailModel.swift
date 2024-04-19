//
//  CocktailDetailModel.swift
//  LatestApp
//
//  Created by Aniket Pithadia on 19/04/24.
//

import Foundation

struct CocktailDetailResult: Codable {
    let drinks: [CocktailDetail]
}
struct CocktailDetail: Codable {
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strInstructions: String
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strDrinkThumb: String
}
