//
//  UserPreferences.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

final class UserPreferences {
    static let shared = UserPreferences()
    private let userDefaults: UserDefaults
    private let lastCountryKey = "last_visited_country"
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// Guarda el nombre del último país visitado en UserDefaults.
    /// - Parameter countryName: El nombre del país a guardar.
    func saveLastVisitedCountry(countryName: String) {
        userDefaults.set(countryName, forKey: lastCountryKey)
    }
    
    /// Obtiene el nombre del último país visitado desde UserDefaults.
    /// - Returns: El nombre del país como un String opcional, o nil si no se ha guardado ninguno.
    func getLastVisitedCountry() -> String? {
        userDefaults.string(forKey: lastCountryKey)
    }
}
