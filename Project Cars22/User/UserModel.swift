//
//  UserModel.swift
//  Project Cars22
//
//  Created by Abderrahmen on 06/11/2024.
//

import SwiftUI

struct User: Codable {
    let _id: String
    let name: String
    let email: String
    let phoneNumber : String
    let region :String
    let role : String
    let image : String
    // Add other fields based on the backend response
}


private enum CodingKeys: String, CodingKey {
      case id = "_id"  // Map "_id" from JSON to the "id" property in the model
      case name
      case email
  }		    
