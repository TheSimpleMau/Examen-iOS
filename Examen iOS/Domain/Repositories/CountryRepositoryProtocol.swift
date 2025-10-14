//
//  CountryRepositoryProtocol.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public protocol CountryRepositoryProtocol {
    func fetchAllCountriesBrief() async throws -> [CountryModel]
    func fetchCountryDetail(byName name: String) async throws -> CountryModel
}
