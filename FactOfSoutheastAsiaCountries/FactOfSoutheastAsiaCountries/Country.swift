//
//  Country.swift
//  FactOfSoutheastAsiaCountries
//
//  Created by user197801 on 6/12/21.
//

import Foundation

struct Country: Codable {
    var countryName: String
    var flag: String
    var capital: String
    var language: String
    var area: Int
    var population: Int
    var currency: String
    var callingCode: String
}
