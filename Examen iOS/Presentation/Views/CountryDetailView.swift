//
//  CountryDetailView.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import SwiftUI

struct CountryDetailView: View {
    
    @StateObject private var viewModel: CountryDetailViewModel
    private let countryName: String
    
    init(countryName: String) {
        self.countryName = countryName
        let countryAPI: CountryAPIProtocol = CountryAPI()
        let countryRepository: CountryRepository = CountryRepository(api: countryAPI)
        let fetchCountryDetailUseCase = FetchCountryDetailUseCase(repository: countryRepository)
        _viewModel = StateObject(wrappedValue: CountryDetailViewModel(fetchCountryDetailUseCase: fetchCountryDetailUseCase))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Cargando detalle...")
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error al cargar")
                        .font(.title)
                    Text(errorMessage)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else if let country = viewModel.country {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        AsyncImage(url: URL(string: country.flagURL ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 200)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text(country.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            InfoRow(label: "Capital", value: country.capital ?? "Este país no cuenta con capítal")
                            if let population = country.population { InfoRow(label: "Población", value: "\(population)" ) }
                            if let region = country.region { InfoRow(label: "Región", value: "\(region)") }
                            if let subregion = country.subregion { InfoRow(label: "Subregión", value: "\(subregion)") }
                            if let languages = country.languages { InfoRow(label: "Idiomas", value: languages.joined(separator: ", ")) }
                            if let currencies = country.currencies {
                                ForEach(currencies, id: \.code) { currency in
                                    InfoRow(
                                        label: "Moneda (\(currency.code))",
                                        value: "\(currency.name) (\(currency.symbol ?? "-"))"
                                    )
                                }
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                }
            }
        }
        .navigationTitle(countryName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadCountryDetail(name: countryName)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.headline)
                .fontWeight(.semibold)
            Text(value)
                .font(.body)
            Spacer()
        }
    }
}

#Preview {
    NavigationView {
        CountryDetailView(countryName: "Mexico")
    }
}
