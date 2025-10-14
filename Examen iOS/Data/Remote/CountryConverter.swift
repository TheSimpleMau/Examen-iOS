//
//  CountryConverter.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

struct CountryConverter: Codable {
    struct NameConverter: Codable {
        let common: String
    }
    struct FlagsConverter: Codable {
        let png: String?
        let svg: String?
        let alt: String?
    }
    struct CurrencyConverter: Codable {
        let name: String
        let symbol: String?
    }

    let name: NameConverter
    let flags: FlagsConverter
    let region: String?
    let subregion: String?
    let capital: [String]?
    let population: Int?
    let languages: [String: String]?
    let currencies: [String: CurrencyConverter]?

    // Conversión a entidad de dominio
    func toDomain() -> CountryModel {
        let langs = languages?.map { $0.value }

        let currs: [CountryModel.Currency]? = currencies?.compactMap { (code, Converter) in
            CountryModel.Currency(code: code,
                                  name: Converter.name,
                                  symbol: Converter.symbol)
        }

        let cap = capital?.first

        let flagURL = flags.png ?? flags.svg

        let emoji = flagEmojiForCountryCode(code: name.common)

        return CountryModel(
            id: name.common,
            name: name.common,
            flagURL: flagURL,
            flagEmoji: emoji,
            region: region,
            subregion: subregion,
            capital: cap,
            population: population,
            languages: langs,
            currencies: currs
        )
    }

    private func flagEmojiForCountryCode(code: String) -> String? {
        // Si tienes algún mapeo de código de país a emoji, o dependiendo del Converter
        return nil
    }
}
