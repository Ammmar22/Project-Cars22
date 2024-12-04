//
//  Message.swift
//  Project Cars22
//
//  Created by Abderrahmen on 25/11/2024.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
