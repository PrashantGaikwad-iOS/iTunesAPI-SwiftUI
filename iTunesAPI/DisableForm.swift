

import SwiftUI

struct DisableForm: View {
    @State private var username = ""
    @State private var password = ""
    
    private var disable: Bool {
        username.count < 5 || password.count < 5
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Username", text: $username)
                    TextField("Password", text: $password)
                }
                
                Section {
                    Button("LOGIN") {
                        print("Login tapped")
                    }
                }
                .disabled(disable)
                //.disabled(username.isEmpty || password.isEmpty)
            }
        .navigationBarTitle("Disable Form")
        }
    }
}

struct DisableForm_Previews: PreviewProvider {
    static var previews: some View {
        DisableForm()
    }
}
