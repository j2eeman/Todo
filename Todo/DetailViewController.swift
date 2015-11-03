//
//  DetailViewController.swift
//  Todo
//
//  Created by cscimac001 on 15/11/2.
//  Copyright © 2015年 Qian Dong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!

    @IBOutlet weak var shoppingCartButton: UIButton!

    @IBOutlet weak var travelButton: UIButton!

    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo:TodoModel?
    
    override func viewDidLoad() {
        //
        todoItem.delegate = self
        
        if todo == nil {
            childButton.selected = true
            navigationController?.navigationItem.title = "新增Todo"
            
        }else {
            navigationController?.navigationItem.title = "修改Todo"
            if todo?.image == "child-selected" {
                childButton.selected = true
            } else if todo?.image == "shopping-cart-selected" {
                shoppingCartButton.selected = true
            } else if todo?.image == "phone-selected" {
                phoneButton.selected = true
            } else if todo?.image == "travel-selected" {
                travelButton.selected = true
            }
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
        
        }
    }
    override func didReceiveMemoryWarning() {
        //
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool{
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        todoItem.resignFirstResponder()
        return true
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        todoItem.resignFirstResponder()
    }
    
    func resetButtons(){
        childButton.selected = false
        phoneButton.selected = false
        shoppingCartButton.selected = false
        travelButton.selected = false
    }
    
    @IBAction func childTapped(sender: AnyObject) {
        resetButtons()
        childButton.selected = true
    }
    
    @IBAction func phoneTapped(sender: AnyObject) {
        resetButtons()
        phoneButton.selected = true
    }
    
    @IBAction func shoppingCartTapped(sender: AnyObject) {
        resetButtons()
        shoppingCartButton.selected = true
    }
    @IBAction func travelTapped(sender: AnyObject) {
        resetButtons()
        travelButton.selected = true
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        var image = ""
        if childButton.selected {
            image = "child-selected"
        } else if phoneButton.selected {
            image = "phone-selected"
        } else if shoppingCartButton.selected{
            image = "shopping-cart-selected"
        } else if travelButton.selected {
            image = "travel-selected"
        }
        if todo == nil{
            let uuid = NSUUID.init().UUIDString
            todo = TodoModel(id: uuid, image: image, title: todoItem.text!, date: todoDate.date)
            todos.append(todo!)
        } else {
            todo?.image = image
            todo?.title = todoItem.text!
            todo?.date = todoDate.date
        
        }
        
    }
    
}
