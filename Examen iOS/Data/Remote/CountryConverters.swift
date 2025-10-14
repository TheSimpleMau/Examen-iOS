//
//  CountryConverters.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public struct CountryAllConverter: Codable {
    struct NameConverter: Codable {
        let common: String?
    }
    struct FlagsConverter: Codable {
        let png: String?
        let svg: String?
        let alt: String?
    }
    
    let name: NameConverter?
    let flags: FlagsConverter?
    let cca2: String?
    let flagEmoji: String?
}


public struct CountryDetailConverter: Codable {
    struct NameConverter: Codable {
        let common: String?
        let official: String?
    }
    struct FlagsConverter: Codable {
        let png: String?
        let svg: String?
        let alt: String?
    }
    struct CurrencyConverter: Codable {
        let name: String?
        let symbol: String?
    }

    let name: NameConverter?
    let flags: FlagsConverter?
    let region: String?
    let subregion: String?
    let capital: [String]?
    let population: Int?
    let languages: [String: String]?
    let currencies: [String: CurrencyConverter]?
    let cca2: String?
}


public struct CountryRegionConverter: Codable {
    let region: String?
    let subregion: String?
    let name: CountryDetailConverter.NameConverter?
}

public struct CountryCapitalConverter: Codable {
    let capital: [String]?
    let name: CountryDetailConverter.NameConverter?
}

public struct CountryPopulationConverter: Codable {
    let population: Int?
    let name: CountryDetailConverter.NameConverter?
}

public struct CountryLanguagesConverter: Codable {
    let languages: [String: String]?
    let name: CountryDetailConverter.NameConverter?
}

public struct CountryCurrenciesConverter: Codable {
    let currencies: [String: CountryDetailConverter.CurrencyConverter]?
    let name: CountryDetailConverter.NameConverter?
}

public struct CountryFlagsConverter: Codable {
    let flags: CountryDetailConverter.FlagsConverter?
    let name: CountryDetailConverter.NameConverter?
}
