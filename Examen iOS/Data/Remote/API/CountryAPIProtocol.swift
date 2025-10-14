//
//  CountryAPIProtocol.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public protocol CountryAPIProtocol {
    
    func getAll() async throws -> [CountryAllConverter]
    func getCountryDetailByName(_ name: String) async throws -> [CountryDetailConverter]
    func getCountryRegionAndSubregion(name: String) async throws -> [CountryRegionConverter]
    func getCountryCapital(name: String) async throws -> [CountryCapitalConverter]
    func getCountryPopulation(name: String) async throws -> [CountryPopulationConverter]
    func getCountryLanguages(name: String) async throws -> [CountryLanguagesConverter]
    func getCountryCurrencies(name: String) async throws ->[CountryCurrenciesConverter]
    func getCountryFlags(name: String) async throws -> [CountryFlagsConverter]
    
}
