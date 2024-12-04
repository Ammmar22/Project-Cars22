import SwiftUI

class ViewModel: ObservableObject {
    @Published var token: String? // Holds the token upon successful login
    @Published var loginError: String? // To show error messages in the UI
    @Published var isAuthenticated: Bool = false
    @Published var userName: String? // Add this property
    @Published var forgotError: String? // To show error messages in the UI
    @Published var isVerified: Bool = false
    @Published var id: String?
    @Published var errorPassword: String?
    @Published var email: String = ""
       @Published var password: String = ""
    @Published var userrole: String = ""
    @Published var bookings: [Booking] = []

    @Published var user: User? // Assuming you have a User model



    
    func updateBookingStatus(id: String, newEtat: Int,mechanicId: String) {
        guard let url = URL(string: "http://localhost:3000/booking/\(id)") else { return }

             // Create the request
             var request = URLRequest(url: url)
             request.httpMethod = "PUT"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             
             // The request body with the updated status (etat)
        let body: [String: Any] = ["etat": newEtat,"mechanicId": mechanicId]
             request.httpBody = try? JSONSerialization.data(withJSONObject: body)

             // Create and perform the network task
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error {
                     print("Error updating booking: \(error.localizedDescription)")
                     return
                 }

                 if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                     // Successfully updated booking
                     DispatchQueue.main.async {
                         // Update the bookings array if needed, or fetch the updated data
                         if let index = self.bookings.firstIndex(where: { $0.id == id }) {
                             self.bookings[index].etat = newEtat
                             self.bookings[index].mechanicId = mechanicId

                         }
                     }
                 } else {
                     print("Failed to update booking: \(String(describing: response))")
                 }
             }
             
             task.resume()
         }
    
    
    func updateBookingVu(id: String, newVu: Bool) {
        guard let url = URL(string: "http://localhost:3000/booking/Vu/\(id)") else { return }

             // Create the request
             var request = URLRequest(url: url)
             request.httpMethod = "PUT"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             
             // The request body with the updated status (etat)
        let body: [String: Any] = ["vu": newVu]
             request.httpBody = try? JSONSerialization.data(withJSONObject: body)

             // Create and perform the network task
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error {
                     print("Error updating booking: \(error.localizedDescription)")
                     return
                 }

                 if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                     // Successfully updated booking
                     DispatchQueue.main.async {
                         // Update the bookings array if needed, or fetch the updated data
                         if let index = self.bookings.firstIndex(where: { $0.id == id }) {
                             self.bookings[index].vu = newVu

                         }
                     }
                 } else {
                     print("Failed to update booking: \(String(describing: response))")
                 }
             }
             
             task.resume()
         }
     
    
    
    

    func login(email: String, password: String,  completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/auth/login") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        URLSession.shared.dataTask(with: request) { data, response, error in
                  if let data = data {
                      do {
                          if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                             let token = json["accessToken"] as? String,
let id = json["userId"] as? String,
                             let role = json["role"] as? String
                        {
                              DispatchQueue.main.async {
                                  // Store the token in UserDefaults or Keychain
                                  UserDefaults.standard.set(token, forKey: "authToken")
                                  UserDefaults.standard.set(id, forKey: "userId") // Store in UserDefaults
                                  UserDefaults.standard.set(role, forKey: "role") // Store in UserDefaults
                                  self.userrole = "Mechanic"
                                  print("good",self.isAuthenticated)
                                  print(token)
                                  self.token=token
                                  self.id=id
                                  print(id)

                                  self.fetchUser(id2: id, token2: token) { success in
                                      if success {
                                          // Handle successful user fetch
                                          print("User fetch was successful")
                                          self.loginError = nil
                                          self.isAuthenticated = true
                                          // Continue with any additional logic if needed
                                          completion(true)

                                      } else {
                                          // Handle failure in fetching user
                                          print("Failed to fetch user")
                                          self.loginError = "Failed to fetch user"
                                          completion(false)

                                      }
                                  }

                                  
                              }
                          }else {
                              completion(false)
                          }
                      } catch {
                          print("Error decoding response: \(error)")
                          completion(false)

                      }
                  } else {
                      print("Error: \(error?.localizedDescription ?? "No data")")
                      completion(false)

                  }
              }.resume()
    }
    
    
    
    func Forgotpassword(email: String )  {
        guard let url = URL(string: "http://localhost:3000/auth/forgot-password") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
                  if let data = data {
                      do {
                          if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]   ,
                             let id = json["id"] as? String{
                              DispatchQueue.main.async {
                                  self.id = id
                                  self.forgotError = nil
                                  print(self.id!)
                                  print("hello")
                                  UserDefaults.standard.set(id, forKey: "userId") // Store in UserDefaults

                                  
                              }
                          }
                      } catch {
                          print("Error decoding response: \(error)")
                      }
                  } else {
                      print("Error: \(error?.localizedDescription ?? "No data")")
                  }
              }.resume()
    }
    
    func verifyotp( codeotp: String,  completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/auth/verify-otp") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "otpCode": codeotp,
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginError = "Network error"
                    print("error")
                    completion(false)
                }	
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Response status code:", httpResponse.statusCode)

                // Parse the response and extract the token
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                {
                    DispatchQueue.main.async {
                        self.isVerified = true
                        self.loginError = nil 
                        print("is good")// Clear error on success
                        completion(true)

                    }
                } else {
                    DispatchQueue.main.async {
                        self.loginError = "Invalid response from server"
                        completion(false)

                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.loginError = "Invalid credentials"
                    print("Response error55")
                    print(codeotp)
                    completion(false)

                    
                    

                }
            }
        }.resume()
    }
    
  
    
    
    func signup(image:URL, email: String, password: String,name: String, phone : String, role:String , region :String,  completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "http://localhost:3000/auth/signup") else {
            print("Invalid URL")
            return
        }
     
        
        let imageString = image.absoluteString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "email": email,
            "password": password,
            "name":name,
            "phoneNumber":phone,
            "region":region,
            "role":role,
            "image": imageString
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginError = "Network error"
                    print("error")
                    completion(false)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Response status code:", httpResponse.statusCode)
                completion(true)
                print("gg",imageString)
                print(image)
                // Parse the response and extract the token
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                {
                    DispatchQueue.main.async {
                       
                        self.loginError = nil // Clear error on success
                        completion(true)

                    }
                } else {
                    DispatchQueue.main.async {
                        self.loginError = "Invalid response from server"
                        completion(false)


                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.loginError = "Invalid credentials"
                    print("Response error55")
                    print(email)
                    print(password)
                    print(region)
                    print(imageString)
                    print(image)
                    completion(false)


                }
            }
        }.resume()
    }
    
    
    func deleteUser(id:String, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://localhost:3000/auth/delete") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "_id":id,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginError = "Network error"
                    print("error")
                    completion(false)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Response status code:", httpResponse.statusCode)
                completion(true)
               
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                {
                    DispatchQueue.main.async {
                       
                        self.loginError = nil // Clear error on success
                        completion(true)

                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)


                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)


                }
            }
        }.resume()    }
    
    
    
    func updateUser(
        id: String,
        token: String,
        email: String,
        phoneNumber: String,
        region: String,
        role: String,
        completion: @escaping (Bool) -> Void
    ) {

        guard let url = URL(string: "http://localhost:3000/auth/profile") else {
            print("Invalid URL")
            return
        }
     
        

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "userId":id,
            "email": email,
                  "phoneNumber": phoneNumber,
                  "region": region,
                  "role": role
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginError = "Network error"
                    print("error")
                    completion(false)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Response status code:", httpResponse.statusCode)
                completion(true)
               
                // Parse the response and extract the token
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                {
                    DispatchQueue.main.async {
                       
                        self.loginError = nil // Clear error on success
                        completion(true)

                    }
                } else {
                    DispatchQueue.main.async {
                        self.loginError = "Invalid response from server"
                        completion(false)


                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.loginError = "Invalid credentials"
                    print("Response error55")
                 
                    completion(false)


                }
            }
        }.resume()
    }
    
    
    func RestPassword(password: String,  completion: @escaping (Bool) -> Void) {

        guard let storedId = UserDefaults.standard.string(forKey: "userId") else {
              print("Error: User ID is nil")
              completion(false)
              return
          }
        
        guard let url = URL(string: "http://localhost:3000/auth/reset-password") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "id": storedId,
            "newPassword": password,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginError = "Network error"
                    print("error")
                    completion(false)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    print("Response status code:", httpResponse.statusCode)

                    self.errorPassword = nil
                    print("reset password succeful")
                    print(password)
                    completion(true)
                }
               
            } else {
               
                    self.errorPassword = "check you password it must be 6 charchtere"
                    completion(false)
                    print("check it")
                print(storedId)
                print(password)


                
            }
        }.resume()
    }
    
    
    
    func logout(completion: @escaping (Bool) -> Void) {
          
           userName = nil
        email = ""
             password = ""
             isAuthenticated = false
             UserDefaults.standard.removeObject(forKey: "authToken")
             UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "role")

        completion(true)
       }
    
    
    func fetchUser( id2: String,token2 :String,  completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "http://localhost:3000/auth/connect/\(id2)") else {
                print("Invalid URL")
                return
            }
        print(id2)
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token2)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.loginError = "Network error: \(error?.localizedDescription ?? "Unknown error")"
                        completion(false)
                    }
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        print("i am here bro")
                        // Decode JSON response into User model
                        let user = try JSONDecoder().decode(User.self, from: data)
                        DispatchQueue.main.async {
                            print("hi",user.name)
                            self.user = user
                            self.loginError = nil
                            print("aa",self.user!.image )
                            completion(true)

                        }
                    } catch let decodingError{
                        DispatchQueue.main.async {
                            self.loginError = "Failed to decode user data"
                            print("Decoding error: \(decodingError)")
                            completion(false)

                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.loginError = "Invalid credentials or user not found"
                        print("problem")
                        completion(false)

                    }
                }
            }.resume()
        }
    
    func Bookings(completion: @escaping ( Bool?) -> Void) {
            guard let url = URL(string: "http://localhost:3000/booking") else {
                print("Invalid URL")
                return
            }
            
        var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        // Decode JSON response into an array of Booking
                        let fetchedBookings = try JSONDecoder().decode([Booking].self, from: data)
                        DispatchQueue.main.async {
                            completion(true)
                            self.bookings = fetchedBookings

                        }
                    } catch let decodingError {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }.resume()
        }
  
  
    
    
    func imageToBase64(image: UIImage) -> String {
         guard let imageData = image.jpegData(compressionQuality: 0.8) else {
             return ""
         }
         return imageData.base64EncodedString()
     }


}
