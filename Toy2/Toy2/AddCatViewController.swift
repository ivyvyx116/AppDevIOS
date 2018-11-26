//
//  AddCatViewController.swift
//  Toy2
//
//  Created by 许文祺 on 11/17/18.
//  Copyright © 2018 Ivy Xu. All rights reserved.
//

import UIKit

class AddCatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isPickerViewOpened : Bool = false
    
    @IBOutlet weak var TableView: UITableView!
    @IBAction func ClearButtonTapped(_ sender: Any) {
        age = "-1"
        name = ""
        type = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    @IBAction func DoneButtonTapped(_ sender: Any) {
        Cat.addCat(name: name, image: #imageLiteral(resourceName: "12535AE6-A60B-4C10-93F3-D5A04EB93642"), age: age, type: type)
        age = "-1"
        name = ""
        type = ""
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        DoneButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // dispose of any resources that can be recreated
    }
    
    // MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2
        } else {
            if (isPickerViewOpened) {
                return 2
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCatCell", for: indexPath) as! AddCatTableViewCell
        cell.TextView.tag = indexPath.row
        cell.TextView.textContainer.maximumNumberOfLines = 1
        cell.TextView.textContainer.lineBreakMode = .byTruncatingTail
        cell.PickerView.isHidden = true
        if (indexPath.section == 0){
            cell.TextView.isEditable = true
            cell.TextView.textColor = UIColor.gray
            cell.TextView.isScrollEnabled = false
            if (indexPath.row == 0){
                cell.TextView.text = "Name"
            } else {
                cell.TextView.text = "Type"
            }
        } else {
            if (indexPath.row == 0) {
                cell.TextView.isEditable = false
                cell.TextView.isSelectable = false
                cell.TextView.textColor = UIColor.black
                cell.TextView.isUserInteractionEnabled = false
                cell.TextView.isHidden = false
                if (age == "-1"){
                    cell.TextView.text = "Age"
                    cell.TextView.textColor = UIColor.gray
                } else {
                    cell.TextView.text = "Age " + age
                    cell.TextView.textColor = UIColor.black
                    var ageRow : Int = -1
                    if (age == "20+") {
                        ageRow = 21
                    } else {
                        ageRow = Int(age) ?? -1
                    }
                    cell.PickerView.selectRow(ageRow, inComponent: 0, animated: false)
                }
            } else {
                cell.TextView.isHidden = true
                cell.PickerView.isHidden = false
            }
        }
        cell.addCatViewController = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 50
        } else {
            if (indexPath.row == 0) {
                return 50
            } else {
                return 100
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            if (isPickerViewOpened) {
                isPickerViewOpened = false
            } else {
                isPickerViewOpened = true
            }
            tableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
