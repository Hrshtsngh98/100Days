//
//  User.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/31/25.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Hashable {
    let name: String
    let id: String
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
