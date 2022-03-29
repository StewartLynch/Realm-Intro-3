//
//  RealmManager.swift
//  Realm Intro-2
//
//  Created by Stewart Lynch on 2022-03-08.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var realm: Realm?
    @Published var countries: Results<Country>?
    var countriesArray: [Country] {
        if let countries = countries {
            return Array(countries)
        } else {
            return []
        }
    }
    private var countriesToken: NotificationToken?
    
    init(name: String) {
        initializeSchema(name: name)
        setupObserver()
    }
    
    func setupObserver() {
        guard let realm = realm else { return }
        let observedCountries = realm.objects(Country.self)
        countriesToken = observedCountries.observe({ [weak self] _ in
            self?.countries = observedCountries
        })
    }
    
    func initializeSchema(name: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFileUrl = docDir.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFileUrl, schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Country.className()) { _, newObject in
                    newObject!["flag"] = "🏳️"
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        print(docDir.path)
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm", error)
        }
        
    }
}
