//
//  CountryRowView.swift
//  Examen iOS
//
//  Created by Mauricio Olguín on 14/10/25.
//

import SwiftUI

struct CountryRowView: View {
    let country: CountryModel
    
    var body: some View {
        HStack {
            Text(country.flagEmoji ?? "🏳️")
                .font(.largeTitle)
                .frame(width: 50, alignment: .center)
            Text(country.name)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
