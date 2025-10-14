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
            AsyncImage(url: URL(string: country.flagURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 2)
            } placeholder: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 30)
            }
            Text(country.name)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
