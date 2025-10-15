//
//  CountryListView.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//


import SwiftUI

struct CountryListView: View {
    
    @StateObject private var viewModel: CountryListViewModel
    @State private var navigationPath = NavigationPath()
    @State private var didNavigateOnAppear = false
    @State private var showingInfoCard = false
    
    init() {
        let countryAPI: CountryAPIProtocol = CountryAPI()
        let countryRepository: CountryRepository = CountryRepository(api: countryAPI)
        let fetchAllCountriesUseCase = FetchAllCountriesUseCase(repository: countryRepository)
        
        _viewModel = StateObject(wrappedValue: CountryListViewModel(fetchAllCountriesUseCase: fetchAllCountriesUseCase))
    }
    
    var body: some View {
        ZStack {
            NavigationStack(path: $navigationPath) {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Cargando países...")
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack {
                            Text("Ha ocurrido un error :(\nvuelve a intentar más tarde.")
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
                        .searchable(text: $viewModel.searchText, prompt: "Busca un país")
                    }
                }
                .navigationTitle("🗺️ Países del Mundo")
                .navigationDestination(for: String.self) { countryName in
                    CountryDetailView(countryName: countryName)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                showingInfoCard = true
                            }
                        }) {
                            Image(systemName: "info.circle")
                        }
                    }
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
            
            if showingInfoCard {
                InfoCardView(isPresented: $showingInfoCard)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

struct InfoCardView: View {
    @Binding var isPresented: Bool
    
    private var infoText: String {
        """
        ¡Hola profesores!
        
        El tiempo no me ha dado para entregarlo para obtener el 100 :(
        Pero aquí le dejo una breve explicación de cómo es que fue estruturdo esta aplicación :)

        • Arquitectura:
        La app utiliza MVVM y principios de Clean Architecture. La estructura separa la presentación, el dominio y datos. Para la parte de la presentación, esta está compuesta por las `Views` y los `ViewsModels`. Luego, tenemos la parte del dominio, la cual conitene los `Models`, los `UseCases` y los `Protocols`. Por último, tenemos la parte de los datos, la cual, incluye implementaciones concretas, que después son utilizadas para la comunicación con la API.
            • Interfaz de Dominio:
            Un ejemplo de cómo lo anterior es el aplicado, es con el archivo `CountryRepositoryProtocol`. Este protocol define un contrato sobre qué datos obtener de los países, permitiendo que la capa de dominio no dependa de cómo se obtienen.

        • Guardado de Preferencias:
        Para recordar el último país que el usuario visitó, se utiliza la clase `UserPreferences`. Se emplea un singleton y se gestiona el almacenamiento de datos simples directamente en `UserDefaults`

        • Estrategia de Búsqueda:
        La búsqueda se implementó, mismamente, en el archivo `CountryListViewModel`. Lo que hace es filtra la lista de países (en tiempo real) a medida que el usuario escribe. Esta implementación fue bastante sencilla pues, al hacerlo con el objeto `List`, ya tiene una integración propia, por lo que ahorra mucho el trabajo. 
        """
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Info del Proyecto")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    withAnimation {
                        isPresented = false
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray.opacity(0.8))
                }
            }
            
            Divider()
            
            Text(infoText)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(30)
    }
}


#Preview {
    CountryListView()
}
