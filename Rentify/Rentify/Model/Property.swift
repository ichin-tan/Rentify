//
//  Property].swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import Foundation

class Property: Codable {
    
    var id: String
    var imgUrl: String
    var streetAddress: String
    var city: String
    var country: String
    var rent: Double
    var latitude: Double
    var longitude: Double
    var addedByLandlordId: String

    init(id: String, imgUrl: String, streetAddress: String, city: String, country: String, rent: Double, latitude: Double, longitude: Double, addedByLandlordId: String) {
        self.id = id
        self.imgUrl = imgUrl
        self.streetAddress = streetAddress
        self.city = city
        self.country = country
        self.rent = rent
        self.latitude = latitude
        self.longitude = longitude
        self.addedByLandlordId = addedByLandlordId
    }
}
