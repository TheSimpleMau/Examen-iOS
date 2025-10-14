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
    func saveLastVisitedCountry(countryName: String) {
        userDefaults.set(countryName, forKey: lastCountryKey)
    }
    func getLastVisitedCountry() -> String? {
        userDefaults.string(forKey: lastCountryKey)
    }
}
