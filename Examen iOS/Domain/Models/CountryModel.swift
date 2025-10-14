//
//  CountryModel.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public struct CountryModel: Identifiable, Equatable {
    public let id: String // El nombre común del país será utilizado como id
    public let name: String
    public let flagURL: String?
    public let flagEmoji: String?
    public let region: String?
    public let subregion: String?
    public let capital: String?
    public let population: Int?
    public let languages: [String]?
    public let currencies: [Currency]?

    public struct Currency: Equatable {
        public let code: String
        public let name: String
        public let symbol: String?
    }

    public init(
        id: String,
        name: String,
        flagURL: String?,
        flagEmoji: String?,
        region: String? = nil,
        subregion: String? = nil,
        capital: String? = nil,
        population: Int? = nil,
        languages: [String]? = nil,
        currencies: [Currency]? = nil
    ) {
        self.id = id
        self.name = name
        self.flagURL = flagURL
        self.flagEmoji = flagEmoji
        self.region = region
        self.subregion = subregion
        self.capital = capital
        self.population = population
        self.languages = languages
        self.currencies = currencies
    }
}
