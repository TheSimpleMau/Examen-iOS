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
    
    func loadCountries() {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            do {
                let fetchedCountries = try await fetchAllCountriesUseCase.execute()
                self.countries = fetchedCountries.sorted { $0.name < $1.name }
            } catch {
                self.errorMessage = "Error al cargar los países :(\n \(error.localizedDescription)"
            }
            self.isLoading = false
        }
    }
    
    func getLastVisitedCountryName() -> String? {
        userPreferences.getLastVisitedCountry()
    }
}
