//
//  CountryRepository.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

final class CountryRepository: CountryRepositoryProtocol {
    
    private let api: CountryAPIProtocol
    
    init(api: CountryAPIProtocol) {
        self.api = api
    }

    func fetchAllCountriesBrief() async throws -> [CountryModel] {
        let countryConverters = try await api.getAll()
        let countryModels = countryConverters.compactMap { converter -> CountryModel? in
            guard let name = converter.name?.common, let id = converter.cca2 else {
                return nil
            }
            return CountryModel(
                id: id,
                name: name,
                flagURL: converter.flags?.png,
                flagEmoji: converter.flagEmoji
            )
        }
        return countryModels
    }
    
    func fetchCountryDetail(byName name: String) async throws -> CountryModel {
        guard let detailConverter = try await api.getCountryDetailByName(name).first else {
            throw URLError(.cannotFindHost)
        }
        guard let name = detailConverter.name?.common, let id = detailConverter.cca2 else {
            throw URLError(.badServerResponse)
        }
        let currencies = detailConverter.currencies?.map { code, currencyInfo -> CountryModel.Currency in
            return CountryModel.Currency(
                code: code,
                name: currencyInfo.name ?? "N/A",
                symbol: currencyInfo.symbol
            )
        }
        let languages = detailConverter.languages?.values.map { $0 }
        let countryModel = CountryModel(
            id: id,
            name: name,
            flagURL: detailConverter.flags?.png,
            flagEmoji: nil,
            region: detailConverter.region,
            subregion: detailConverter.subregion,
            capital: detailConverter.capital?.first,
            population: detailConverter.population,
            languages: languages,
            currencies: currencies
        )
        return countryModel
    }
}
