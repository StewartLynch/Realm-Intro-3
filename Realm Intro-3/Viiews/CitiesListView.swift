//
//  CitiesListView.swift
//  Realm Intro-3
//
//  Created by Stewart Lynch on 2022-03-07.
//

import SwiftUI
import RealmSwift


struct CitiesListView: View {
    @ObservedRealmObject var country: Country
    @State private var name = ""
    @FocusState private var isFocused: Bool?
    var body: some View {
        VStack {
            HStack {
                TextField("New City", text: $name)
                    .focused($isFocused, equals: true)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    let newCity = City(name: name)
                    $country.cities.append(newCity)
                    name = ""
                    isFocused = nil
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(name.isEmpty)
            }
            .padding()
            List {
                ForEach(country.cities) { city in
                    Text(city.name)
                }
                .onDelete(perform: $country.cities.remove)
                .onMove(perform: $country.cities.move)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .animation(.default, value: country.cities)
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button {
                        isFocused = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView(country: Country(name: "Canada"))
    }
}
