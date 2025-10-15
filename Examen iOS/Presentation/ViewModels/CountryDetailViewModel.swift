//
//  CountryDetailViewModel.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation
import Combine

@MainActor
final class CountryDetailViewModel: ObservableObject {
    
    @Published var country: CountryModel?
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let fetchCountryDetailUseCase: FetchCountryDetailUseCase
    private let userPreferences: UserPreferences
    
    init(fetchCountryDetailUseCase: FetchCountryDetailUseCase, userPreferences: UserPreferences = .shared) {
        self.fetchCountryDetailUseCase = fetchCountryDetailUseCase
        self.userPreferences = userPreferences
    }
    
    /// Carga el detalle de un país específico por su nombre y actualiza el estado del ViewModel.
    /// - Parameter name: El nombre del país a cargar.
    func loadCountryDetail(name: String) async {
        self.country = nil
        self.isLoading = true
        self.errorMessage = nil
        do {
            let fetchedCountry = try await fetchCountryDetailUseCase.execute(name: name)
            self.country = fetchedCountry
            saveLastVisitedCountry(name: fetchedCountry.name)
        } catch {
            if let apiError = error as? CountryAPIError {
                switch apiError {
                case .noInternetConnection:
                    self.errorMessage = "error con la conexión\n¿tienes internet 🧐? verificalo para continuar"
                case .serverError:
                    self.errorMessage = "error el servidor ;( \nintenta más tarde"
                default:
                    self.errorMessage = "Error al cargar el detalle del país :(\n \(error.localizedDescription)"
                }
            } else {
                self.errorMessage = "Error al cargar el detalle del país :(\n \(error.localizedDescription)"
            }
        }
        self.isLoading = false
    }
    
    /// Guarda el nombre del último país visitado utilizando la instancia de UserPreferences.
    /// - Parameter name: El nombre del país que se va a guardar.
    private func saveLastVisitedCountry(name: String) {
        userPreferences.saveLastVisitedCountry(countryName: name)
    }
}
