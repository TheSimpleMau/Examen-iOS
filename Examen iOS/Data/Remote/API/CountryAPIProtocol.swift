//
//  CountryAPIProtocol.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import Foundation

public protocol CountryAPIProtocol {
    
    func getAll(fields: [String]) async throws -> [CountryConverter]
    
    
    
}
