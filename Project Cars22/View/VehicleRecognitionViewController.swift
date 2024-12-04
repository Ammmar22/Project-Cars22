import Foundation

// Function to call the API and get the vehicle recognition response
func callVehicleRecognitionAPI(withImageURL imageURL: String, completion: @escaping (String?, Error?) -> Void) {
    // Define the headers
    let headers = [
        "x-rapidapi-key": "78dc512ea1msh02dca3dedf60e51p1fbbc6jsn62517e02282c",
        "x-rapidapi-host": "vehicle-make-and-model-recognition.p.rapidapi.com",
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    // Prepare the post data (URL-encoded form data)
    let postData = NSMutableData(data: "inputurl=https://drive.google.com/uc?export=view&id=194r_iQcp8fOT9ZGRr0SxmRjTNMYdejPc".data(using: .utf8)!)

    // Create the request
    let url = URL(string: "https://vehicle-make-and-model-recognition.p.rapidapi.com/v1")!
    let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData as Data
    
    // Send the request
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        // Check for a valid response
        if let data = data {
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Code: \(httpResponse.statusCode)")
            }
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString, nil)  // Return the response as a string
            }
        } else {
            completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
        }
    }
    
    dataTask.resume()
}
