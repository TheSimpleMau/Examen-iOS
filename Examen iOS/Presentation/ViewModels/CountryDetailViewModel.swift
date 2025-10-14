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
    
    func loadCountryDetail(name: String) async {
        self.country = nil
        self.isLoading = true
        self.errorMessage = nil
        do {
            let fetchedCountry = try await fetchCountryDetailUseCase.execute(name: name)
            self.country = fetchedCountry
            saveLastVisitedCountry(name: fetchedCountry.name)
        } catch {
            self.errorMessage = "Error al cargar el detalle del país: \(error.localizedDescription)"
            debugPrint(error)
        }
        self.isLoading = false
    }
    
    private func saveLastVisitedCountry(name: String) {
        userPreferences.saveLastVisitedCountry(countryName: name)
    }
}
