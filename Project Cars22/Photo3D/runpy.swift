import Foundation
import UIKit

func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "http://127.0.0.1:8000/generate/") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    let imageData = image.jpegData(compressionQuality: 0.8)!
    var body = Data()
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"input.jpg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    request.httpBody = body

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }

        let responseString = String(data: data, encoding: .utf8)
        completion(responseString) // Assuming the response is the file path or URL to the model
    }
    task.resume()
}
