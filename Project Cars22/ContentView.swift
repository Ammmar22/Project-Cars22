import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showSignup: Bool = false
    @State private var showMainPage: Bool = false
    @State private var showLoginPage: Bool = true
    @ObservedObject var locationManager = LocationManager.shared

    // Use @AppStorage to dynamically observe changes to "role" and "authToken"
    @AppStorage("role") private var role: String = ""
    @AppStorage("authToken") private var authToken: String = ""

    var body: some View {
        NavigationStack {
                if viewModel.isAuthenticated {
                    if locationManager.userlocation == nil {
                        // Show the location request page
                        LocationRequest()
                            .onAppear {
                                // Trigger location request when user is authenticated
                                locationManager.requestLocation()
                            }
                    }
                        // Navigate based on role
                        if role == "Mechanic" {
                            MenuMechanic(showmainPage: $showMainPage)
                        } else {
                            menu(showmainPage: $showMainPage)
                        }
                    
                
            } else {
                // Show login/signup flow
                Login(showSignup: $showSignup, showMainPage: $showMainPage)
                    .navigationDestination(isPresented: $showSignup) {
                        SignUp(showSignup: $showSignup)
                    }
            }
        }
        .onAppear {
            updateAuthenticationState()
        }
        
        .overlay {
            if (!viewModel.isAuthenticated && !showMainPage) {
                if #available(iOS 17, *) {
                    AnimatedImageView()
                        .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignup)
                } else {
                    AnimatedImageView()
                        .animation(.easeInOut(duration: 0.3), value: showSignup)
                }
            }
        }
       
        .onChange(of: authToken) { _ in
            updateAuthenticationState() // Update state when authToken changes
        }
        .onChange(of: role) { newRole in
            print("Role updated to \(newRole)") // Debug log
        }
        .environmentObject(viewModel)
    }

    private func updateAuthenticationState() {
        // Check if token exists in UserDefaults and update isAuthenticated
        if let _ = UserDefaults.standard.string(forKey: "authToken") {
            viewModel.isAuthenticated = true
            print("hi")
          
        } else {
            viewModel.isAuthenticated = false
            print("mch hi")

        }
    }
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.blue, .blue, .app], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90 : -90, y: -360)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }

    @ViewBuilder
    func AnimatedImageView() -> some View {
        Image("voiture-de-muscle")
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 40 : -39, y: -340)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
            .animation(.easeInOut(duration: 1), value: showSignup) // Match animation properties
    }
}
