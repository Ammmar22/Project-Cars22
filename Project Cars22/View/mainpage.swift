import SwiftUI

struct MainPage: View {
    @Binding var showmainPage: Bool
    @ObservedObject var locationManager = LocationManager.shared
    @State private var isMapPresented = false // State to control presenting ViewMap
    @State private var isChatPresented = false // State to control presenting ViewMap
    @State private var isModel3D = false // State to control presenting ViewMap

    @State private var iscarDetail = false // State to control presenting ViewMap

    
    @EnvironmentObject var viewModel: ViewModel
    @State private var isLoading = true // State to track loading
    @State private var id = UserDefaults.standard.string(forKey: "userId") ?? "Guest"
    @State private var token = UserDefaults.standard.string(forKey: "authToken") ?? "Guest"
    @State private var isUserDetailsPresented = false
static let shared = LocationManager()
    var body: some View {
           NavigationStack {
               VStack {
                   
                   // Main content of the view
                   
                                     Spacer()
                                     HStack {
                                         Button(action: {
                                             isChatPresented.toggle() // Open the chat view
                                         }) {
                                             Image(systemName: "message.fill") // Chat icon
                                                 .font(.system(size: 40)) // Icon size
                                                 .padding()
                                                 .background(Circle().fill(Color.green)) // Circular background
                                                 .foregroundColor(.white)
                                                 .shadow(radius: 10) // Shadow for better visibility
                                         }
                                         .padding(.leading, 10) // Padding to adjust position
                                         
                                         Spacer()
                                         Button(action: {
                                             //isMapPresented.toggle() // Open the chat view
                                           //  isModel3D.toggle()
                                             
                                             iscarDetail.toggle()
                                         }) {
                                             Image(systemName: "map.fill") // Chat icon
                                                 .font(.system(size: 40)) // Icon size
                                                 .padding()
                                                 .background(Circle().fill(Color.blue)) // Circular background
                                                 .foregroundColor(.white)
                                                 .shadow(radius: 10) // Shadow for better visibility
                                         }
                                         .padding(.leading, 190) // Padding to adjust position
                                         
                                         Spacer()
                                     }
                                     .padding(.bottom, 0) // Bottom padding to position above the screen edge
                                 
                   
                   
               }
               .toolbar {
                   // Top-right corner button with an icon
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           isUserDetailsPresented.toggle() // Open UserDetails when clicked

                       }) {
                           Image(systemName: "person.fill") // Your desired icon here
                               .font(.title)
                               .foregroundColor(Color("Bluecar")) // Ensure the color makes the icon visible

                       }
                   }
               }
               .sheet(isPresented: $isUserDetailsPresented) {
                              userdetails(showmainPage: $showmainPage) // Present UserDetailsView when isUserDetailsPresented is true
                          }
               .sheet(isPresented: $isMapPresented) {
                              ViewMap() // Present ViewMap when isMapPresented is true
                          }
               .sheet(isPresented: $isChatPresented) {
                              ChatView() // Present ViewMap when isMapPresented is true
                          }
               .sheet(isPresented: $isModel3D) {
                              Generate3D() // Present ViewMap when isMapPresented is true
                          }
               .sheet(isPresented: $iscarDetail) {
                             // carvinView() // Present ViewMap when isMapPresented is true
                          }
           }
           .navigationBarBackButtonHidden(true) // This hides the back button

       }
}

// Preview
#Preview {
    ContentView()
}
