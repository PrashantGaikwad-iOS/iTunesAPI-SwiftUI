

import SwiftUI

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let collectionName: String
}

struct Response: Codable {
    let results: [Result]
}

struct ContentView: View {
    @State var results = [Result]()
    
    var body: some View {
        NavigationView {
            List(results, id:\.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .onAppear(perform: loadData)
        .navigationBarTitle("iTunes API")
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, reponse, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from:data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
