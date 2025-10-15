//
//  CountryListViewModel.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation
import Combine

@MainActor
final class CountryListViewModel: ObservableObject {
    
    @Published var countries: [CountryModel] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    var filteredCountries: [CountryModel] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private let fetchAllCountriesUseCase: FetchAllCountriesUseCase
    private let userPreferences: UserPreferences
    
    init(fetchAllCountriesUseCase: FetchAllCountriesUseCase, userPreferences: UserPreferences = .shared) {
        self.fetchAllCountriesUseCase = fetchAllCountriesUseCase
        self.userPreferences = userPreferences
    }
    
    /// Carga la lista de países desde el caso de uso y actualiza el estado del ViewModel.
    func loadCountries() {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            do {
                let fetchedCountries = try await fetchAllCountriesUseCase.execute()
                self.countries = fetchedCountries.sorted { $0.name < $1.name }
            } catch {
                if let apiError = error as? CountryAPIError {
                    switch apiError {
                    case .noInternetConnection:
                        self.errorMessage = "error con la conexión\n¿tienes internet 🧐? verificalo para continuar"
                    case .serverError:
                        self.errorMessage = "error el servidor ;(\nintenta más tarde"
                    default:
                        self.errorMessage = "Error al cargar los países :(\n \(error.localizedDescription)"
                    }
                } else {
                    self.errorMessage = "Error al cargar los países :(\n \(error.localizedDescription)"
                }
            }
            self.isLoading = false
        }
    }
    
    /// Obtiene el nombre del último país visitado desde las preferencias del usuario.
    /// - Returns: El nombre del país como un String opcional.
    func getLastVisitedCountryName() -> String? {
        userPreferences.getLastVisitedCountry()
    }
}
