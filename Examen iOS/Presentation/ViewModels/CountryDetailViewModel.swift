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
    
    // Propiedades publicadas que la vista de detalle observará.
    @Published var country: CountryModel?
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    // El caso de uso para obtener el detalle.
    private let fetchCountryDetailUseCase: FetchCountryDetailUseCase
    
    // Inyectamos la dependencia en el inicializador.
    init(fetchCountryDetailUseCase: FetchCountryDetailUseCase) {
        self.fetchCountryDetailUseCase = fetchCountryDetailUseCase
    }
    
    // Función para cargar los datos de un país por su nombre.
    func loadCountryDetail(name: String) {
        self.isLoading = true
        self.errorMessage = nil
        
        Task {
            do {
                // Ejecutamos el caso de uso.
                let fetchedCountry = try await fetchCountryDetailUseCase.execute(name: name)
                self.country = fetchedCountry
            } catch {
                // Si hay un error, lo guardamos.
                self.errorMessage = "Error al cargar el detalle del país: \(error.localizedDescription)"
                print(error)
            }
            self.isLoading = false
        }
    }
}
