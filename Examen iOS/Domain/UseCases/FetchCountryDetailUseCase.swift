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
    /// Ejecuta el caso de uso para obtener el detalle de un país.
    /// - Parameter name: El nombre del país a buscar.
    /// - Returns: Un objeto `CountryModel` con la información detallada.
    public func execute(name: String) async throws -> CountryModel {
        try await repository.fetchCountryDetail(byName: name)
    }
}
