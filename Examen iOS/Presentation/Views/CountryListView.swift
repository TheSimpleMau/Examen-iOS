import SwiftUI

struct CountryListView: View {
    
    @StateObject private var viewModel: CountryListViewModel
    @State private var navigationPath = NavigationPath()
    @State private var didNavigateOnAppear = false
    
    init() {
        let countryAPI: CountryAPIProtocol = CountryAPI()
        let countryRepository: CountryRepository = CountryRepository(api: countryAPI)
        let fetchAllCountriesUseCase = FetchAllCountriesUseCase(repository: countryRepository)
        
        _viewModel = StateObject(wrappedValue: CountryListViewModel(fetchAllCountriesUseCase: fetchAllCountriesUseCase))
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                    List(viewModel.filteredCountries) { country in
                        NavigationLink(value: country.name) {
                            CountryRowView(country: country)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Buscar un país")
                }
            }
            .navigationTitle("🗺️ Países del Mundo")
            .navigationDestination(for: String.self) { countryName in
                CountryDetailView(countryName: countryName)
            }
            .onAppear {
                if viewModel.countries.isEmpty {
                    viewModel.loadCountries()
                }
                if !didNavigateOnAppear {
                    if let countryName = viewModel.getLastVisitedCountryName() {
                        navigationPath.append(countryName)
                        didNavigateOnAppear = true
                    }
                }
            }
        }
    }
}

#Preview {
    CountryListView()
}

