//
//  CountryAPIProtocol.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public protocol CountryAPIProtocol {
    /// Obtiene una lista breve de todos los países.
    /// - Returns: Un arreglo de `CountryAllConverter`.
    func getAll() async throws -> [CountryAllConverter]
    /// Obtiene el detalle de un país específico por su nombre.
    /// - Parameter name: El nombre del país a buscar.
    /// - Returns: Un arreglo de `CountryDetailConverter`.
    func getCountryDetailByName(_ name: String) async throws -> [CountryDetailConverter]
    /// Obtiene la región y subregión de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryRegionConverter`.
    func getCountryRegionAndSubregion(name: String) async throws -> [CountryRegionConverter]
    /// Obtiene la capital de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryCapitalConverter`
    func getCountryCapital(name: String) async throws -> [CountryCapitalConverter]
    /// Obtiene la población de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryPopulationConverter`.
    func getCountryPopulation(name: String) async throws -> [CountryPopulationConverter]
    /// Obtiene los idiomas de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryLanguagesConverter`.
    func getCountryLanguages(name: String) async throws -> [CountryLanguagesConverter]
    /// Obtiene las monedas de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryCurrenciesConverter`.
    func getCountryCurrencies(name: String) async throws ->[CountryCurrenciesConverter]
    /// Obtiene las banderas de un país.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un arreglo de `CountryFlagsConverter`.
    func getCountryFlags(name: String) async throws -> [CountryFlagsConverter]
    
}
