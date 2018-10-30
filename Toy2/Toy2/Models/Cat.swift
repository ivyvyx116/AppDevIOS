import UIKit

class Cat: NSObject {
    struct CatCellInfo {
        let name : String!
        let image : UIImage!
        let age : Int!
        let type : String!
    }
    
    static var count : Int = 0
    static var catArr = [CatCellInfo]()
    
    class func addCat(name: String!, image: UIImage!, age: Int!, type:String!) -> Void {
        catArr.append(CatCellInfo(name: name, image: image, age: age, type: type))
        count += 1 
    }
    
    class func loadCats(completion : @escaping (Array<Dictionary<String,String>>) -> Void) -> Void {
        let url = URL(string: "http://www.chenziwe.com/cats")
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print("Failed to load cats...")
                return
            }
            print("Hey here comes our cats!")
            let result = try? JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary<String,String>>
            completion(result!)
        }
        task.resume()
    }
}
