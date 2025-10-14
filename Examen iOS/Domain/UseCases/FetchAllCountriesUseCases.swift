//
//  FetchAllCountriesUseCases.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public struct FetchAllCountriesUseCase {
    private let repository: CountryRepositoryProtocol
    public init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    public func execute() async throws -> [CountryModel] {
        try await repository.fetchAllCountriesBrief()
    }
}
