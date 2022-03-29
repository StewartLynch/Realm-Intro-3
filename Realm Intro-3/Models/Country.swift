//
//  Country.swift
//  Realm Intro-3
//
//  Created by Stewart Lynch on 2022-03-07.
//

import Foundation
import RealmSwift

class Country: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var cities: List<City>
    @Persisted var flag = "🏳"
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
