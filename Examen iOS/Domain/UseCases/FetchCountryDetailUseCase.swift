//
//  FetchCountryDetailUseCase.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public struct FetchCountryDetailUseCase {
    private let repository: CountryRepositoryProtocol
    public init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    public func execute(name: String) async throws -> CountryModel {
        try await repository.fetchCountryDetail(byName: name)
    }
}
