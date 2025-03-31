//
//  User.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/31/25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    init (
        id: String,
        isActive: Bool,
        name: String,
        age: Int,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: Date,
        tags: [String],
        friends: [Friend]) {
            self.id = id
            self.isActive = isActive
            self.name = name
            self.age = age
            self.company = company
            self.email = email
            self.address = address
            self.about = about
            self.registered = registered
            self.tags = tags
            self.friends = friends
        }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(Date.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }
}

@Model
class Friend: Codable, Hashable {
    var id: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case name
        case id
    }
    
    init (name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
    
}


extension User {
    static var example: User = .init(id: "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
                                     isActive: true,
                                     name: "Gale Dyer",
                                     age: 28,
                                     company: "Cemention",
                                     email: "galedyer@cemention.com",
                                     address: "652 Gatling Place, Kieler, Arizona, 1705",
                                     about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
                                     registered: .now,
                                     tags: ["irure",
                                            "labore",
                                            "et",
                                            "sint",
                                            "velit",
                                            "mollit",
                                            "et"],
                                     friends: [
                                        .init(name: "Daisy Bond", id: "1c18ccf0-2647-497b-b7b4-119f982e6292"),
                                        .init(name: "Tanya Roberson", id: "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9")
                                     ])
}
