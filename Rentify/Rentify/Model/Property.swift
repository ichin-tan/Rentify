//
//  Property].swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import Foundation

struct Property: Codable, Identifiable {
    
    var id: String
    var imgUrl: String
    var streetAddress: String
    var city: String
    var country: String
    var rent: Double
    var latitude: Double
    var longitude: Double
    var address: String
    var addedByLandlordId: String
    var isActivated: Bool

    init(id: String, imgUrl: String, streetAddress: String, city: String, country: String, rent: Double, latitude: Double, longitude: Double, addedByLandlordId: String, address: String, isActivated: Bool) {
        self.id = id
        self.imgUrl = imgUrl
        self.streetAddress = streetAddress
        self.city = city
        self.country = country
        self.rent = rent
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.addedByLandlordId = addedByLandlordId
        self.isActivated = isActivated
    }
}
