

import Foundation
class APIClient:NSObject {
    
    func getProducts(completion: @escaping (([Products]) -> Void)) {
        do{
            if let bundlePath = Bundle.main.path(forResource: "menu",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf16) {
                completion(parse(jsonData: jsonData))
            }
            
        }
        catch{
            print("")
            
        }
    }
    private func parse(jsonData: Data) -> [Products] {
        do {
            let decodedData = try! JSONDecoder().decode(Array<Products>.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        
    }
}
