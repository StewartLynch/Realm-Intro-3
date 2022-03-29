//
//  CountryRowView.swift
//  Realm Intro-3
//
//  Created by Stewart Lynch on 2022-03-07.
//

import SwiftUI
import RealmSwift

struct CountryRowView: View {
    @ObservedRealmObject var country: Country
    @FocusState var isFocused: Bool?
    @State private var showFlagPicker = false
    var body: some View {
        HStack {
            Button {
                showFlagPicker = true
            } label: {
                Text(country.flag)
            }
            .buttonStyle(.plain)
            TextField("New Country", text: $country.name)
                .focused($isFocused, equals: true)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            Spacer()
            Text("\(country.cities.count) cities")
        }
            .padding()
            .frame(height: 30)
            .sheet(isPresented: $showFlagPicker) {
                FlagPicker(country: country)
            }
    }
}

struct CountryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRowView(country: Country(name: "Canada"))
    }
}
