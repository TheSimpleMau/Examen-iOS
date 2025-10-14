//
//  CountryListView.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import SwiftUI

struct CountryListView: View {
    
    @StateObject private var viewModel: CountryListViewModel
    
    init() {
        let countryAPI: CountryAPIProtocol = CountryAPI()
        let countryRepository: CountryRepository = CountryRepository(api: countryAPI)
        let fetchAllCountriesUseCase = FetchAllCountriesUseCase(repository: countryRepository)
        
        _viewModel = StateObject(wrappedValue: CountryListViewModel(fetchAllCountriesUseCase: fetchAllCountriesUseCase))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando países...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Ha ocurrido un error :(\n vuelve a intentar más tarde.")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else {
                    List(viewModel.countries) { country in
                        Text(country.name)
                    }
                }
            }
            .navigationTitle("Países del Mundo")
            .onAppear {
                if viewModel.countries.isEmpty {
                    viewModel.loadCountries()
                }
            }
        }
    }
}

#Preview {
    CountryListView()
}

