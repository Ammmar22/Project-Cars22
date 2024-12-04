import Foundation

struct UserPayload: Codable {
    let userId: String
    let iat: Int
    let exp: Int
    let name: String?
}

func decodeJWT(token: String) -> UserPayload? {
    let parts = token.split(separator: ".")
    guard parts.count == 3 else { return nil }

    let payload = parts[1]
    var payloadData = payload.replacingOccurrences(of: "-", with: "+")
                              .replacingOccurrences(of: "_", with: "/")
    
    // Add padding if necessary
    while payloadData.count % 4 != 0 {
        payloadData += "="
    }
    
    guard let decodedData = Data(base64Encoded: payloadData) else { return nil }
    let userPayload = try? JSONDecoder().decode(UserPayload.self, from: decodedData)
    return userPayload
}
