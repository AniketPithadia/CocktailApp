//
//  ResponseModel.swift
//  LatestApp
//
//  Created by Aniket Pithadia on 19/04/24.
//

import Foundation

struct CocktailResult: Decodable {
    let drinks: [Cocktail]
}

struct Cocktail: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
