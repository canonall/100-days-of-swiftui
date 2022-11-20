//
//  Order.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 06.09.22.
//

import SwiftUI

class OrderWrapper: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}

struct Order: Codable {
    enum Codingkeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    
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
     var streetAddress = ""
     var city = ""
     var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmptyOrWhiteSpace() || streetAddress.isEmptyOrWhiteSpace() || city.isEmptyOrWhiteSpace() || zip.isEmptyOrWhiteSpace() {
            return false
        }
        
        if name.containsNumber() || city.containsNumber() {
            return false
        }
        return true
    }
    
    var checkFields: AddressError {
        if name.containsNumber() {
            return .nameHasNumbers("Name can not contain numbers")
        }
        
        if city.containsNumber() {
            return .cityHasNumbers("City can not contain numbers")
        }
        
        return .valid
    }
    
    var cost: Double {
        //$2 per cake
        var cost = Double(quantity) * 2
        
        //complicated cakes cost more
        cost += (Double(type) / 2)
        
        //$1 for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //$0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost 
    }
    
    //init() { }
    
//    //@Published proprety needs custom encoding and decoding
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Codingkeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
}

enum AddressError {
    case valid, nameHasNumbers(String), cityHasNumbers(String)
}

extension String {
    func isEmptyOrWhiteSpace() ->  Bool {
        
        if self.isEmpty {
            return true
        }
        
        return (self.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        
    }
    
    func containsNumber() -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = self.rangeOfCharacter(from: decimalCharacters)
        
        return decimalRange != nil
    }
}
