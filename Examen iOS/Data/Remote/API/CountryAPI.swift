//
//  CountryAPI.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation
import Alamofire

enum CountryAPIError: Error {
    case badURL
    case serverError(statusCode: Int)
    case decoding(Error)
    case other(Error)
}

final class CountryAPI: CountryAPIProtocol {
    private let session: Session
    private let baseURL = "https://restcountries.com/v3.1"

    init(session: Session = .default) {
        self.session = session
    }

    private func buildURL(path: String, fields: [String]?) throws -> URL {
        guard var comps = URLComponents(string: baseURL + path) else {
            throw CountryAPIError.badURL
        }
        if let fields = fields, !fields.isEmpty {
            comps.queryItems = [URLQueryItem(name: "fields", value: fields.joined(separator: ","))]
        }
        guard let url = comps.url else { throw CountryAPIError.badURL }
        return url
    }
    
    // Función genérica refactorizada para evitar problemas de concurrencia
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            continuation.resume(throwing: CountryAPIError.serverError(statusCode: statusCode))
                        } else if error.isResponseSerializationError {
                            continuation.resume(throwing: CountryAPIError.decoding(error))
                        } else {
                            continuation.resume(throwing: CountryAPIError.other(error))
                        }
                    }
                }
        }
    }

    func getAll() async throws -> [CountryAllConverter] {
        let path = "/all"
        let fields = ["name","flags","cca2", "flag"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryDetailByName(_ name: String) async throws -> [CountryDetailConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["name","flags","region","subregion","capital","population","languages","currencies","cca2", "flag"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryRegionAndSubregion(name: String) async throws -> [CountryRegionConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["region","subregion","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryCapital(name: String) async throws -> [CountryCapitalConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["capital","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryPopulation(name: String) async throws -> [CountryPopulationConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["population","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryLanguages(name: String) async throws -> [CountryLanguagesConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["languages","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryCurrencies(name: String) async throws -> [CountryCurrenciesConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["currencies","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }

    func getCountryFlags(name: String) async throws -> [CountryFlagsConverter] {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? name
        let path = "/name/\(encoded)"
        let fields = ["flags","name"]
        let url = try buildURL(path: path, fields: fields)
        return try await performRequest(url: url)
    }
}
