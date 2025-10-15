//
//  CountryRepositoryProtocol.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public protocol CountryRepositoryProtocol {
    /// Define el contrato para obtener una lista breve de todos los países.
    /// - Returns: Un arreglo de `CountryModel`.
    func fetchAllCountriesBrief() async throws -> [CountryModel]
    /// Define el contrato para obtener el detalle de un país por su nombre.
    /// - Parameter name: El nombre del país.
    /// - Returns: Un objeto `CountryModel`.
    func fetchCountryDetail(byName name: String) async throws -> CountryModel
}
