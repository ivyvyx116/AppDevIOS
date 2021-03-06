//
//  ViewController.swift
//  Toy2
//
//  Created by 许文祺 on 9/30/18.
//  Copyright © 2018 Ivy Xu. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissKeyboardWhenTappingAround() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(false)
    }
}

class ViewController: UIViewController {
    
    var submitted : Bool = false
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ClassYrLabel: UILabel!
    @IBOutlet weak var NameTxtField: UITextField!
    @IBOutlet weak var ClassTxtField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var DisplayLabel: UILabel!
    
    func enterClearMode () -> Void {
        NameLabel.isHidden = true
        ClassYrLabel.isHidden = true
        NameTxtField.isHidden = true
        ClassTxtField.isHidden = true
        DisplayLabel.isHidden = false
        SubmitButton.setTitle("Clear", for: .normal)
        submitted = true
    }
    
    func enterSubmitMode () -> Void {
        NameLabel.isHidden = false
        ClassYrLabel.isHidden = false
        NameTxtField.isHidden = false
        ClassTxtField.isHidden = false
        DisplayLabel.isHidden = true
        SubmitButton.setTitle("Submit", for: .normal)
        submitted = false
    }
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        if (submitted){
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "class year")
            enterSubmitMode()
        } else {
            let name = NameTxtField.text ?? ""
            let classYr = ClassTxtField.text ?? ""
            DisplayLabel.text = "Welcome, " + name + " of " + classYr + "!"
            NameTxtField.text = ""
            ClassTxtField.text = ""
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(classYr, forKey: "class year")
            enterClearMode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappingAround()
        if(UserDefaults.standard.object(forKey: "name") != nil) {
            let name = UserDefaults.standard.string(forKey: "name")
            let classYr = UserDefaults.standard.string(forKey: "class year")
            DisplayLabel.text = "Welcome, " + name! + " of " + classYr! + "!"
            enterClearMode()
        } else {
            enterSubmitMode()
        }
        
        if (Cat.count == 0) {
            Cat.loadCats{ (result) in
                for dict in result {
                    let imageURL = URL(string: dict["image"]!)
                    let image = UIImage(data: try! Data(contentsOf: imageURL!))
                    Cat.addCat(name: dict["name"]!, image: image, age: dict["age"]!, type: dict["type"]!)
            }
            
        }
    }
}
}
