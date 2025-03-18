//
//  Order.swift
//  CupcakeCorner
//
//  Created by Harshit Singh on 3/14/25.
//

import Foundation

enum UDKey {
    static let name = "savedName"
    static let city = "savedCity"
    static let streetAddress = "savedStreetAddress"
    static let zip = "savedZip"
}

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var city = ""
    var streetAddress = ""
    var zip = ""
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    init() {
        name = UserDefaults.standard.string(forKey: UDKey.name) ?? ""
        city = UserDefaults.standard.string(forKey: UDKey.city) ?? ""
        streetAddress = UserDefaults.standard.string(forKey: UDKey.streetAddress) ?? ""
        zip = UserDefaults.standard.string(forKey: UDKey.zip) ?? ""
    }
    
    func saveAddress() {
        UserDefaults.standard.set(name, forKey: UDKey.name)
        UserDefaults.standard.set(streetAddress, forKey: UDKey.streetAddress)
        UserDefaults.standard.set(zip, forKey: UDKey.zip)
        UserDefaults.standard.set(city, forKey: UDKey.city)
    }
    
    var hasValidAddress: Bool {
        if name.trimed().isEmpty ||
            streetAddress.trimed().isEmpty ||
            city.trimed().isEmpty ||
            zip.trimed().isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
}


extension String {
    func trimed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
