//
//  CountryListViewModel.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

import Foundation
import Combine

@MainActor
final class CountryListViewModel: ObservableObject {
    
    @Published var countries: [CountryModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fetchAllCountriesUseCase: FetchAllCountriesUseCase
    
    init(fetchAllCountriesUseCase: FetchAllCountriesUseCase) {
        self.fetchAllCountriesUseCase = fetchAllCountriesUseCase
    }
    
    func loadCountries() {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            do {
                let fetchedCountries = try await fetchAllCountriesUseCase.execute()
                self.countries = fetchedCountries.sorted { $0.name < $1.name }
            } catch {
                self.errorMessage = "Error al cargar los países: \(error.localizedDescription)"
            }
            self.isLoading = false
        }
    }
}

