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
    
}
