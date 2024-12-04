struct Booking: Codable {
    let id: String
    let userId: String

    let date: String
    let time: String
    let problem: String
    var etat: Int
    let v: Int
    var mechanicId: String? 
    var vu : Bool?


    // Map the property names to JSON keys if needed
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, date,time, problem, etat,mechanicId,vu
        case v = "__v"
    }
}
