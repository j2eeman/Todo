//
//  ViewController.swift
//  Todo
//
//  Created by cscimac001 on 15/10/29.
//  Copyright © 2015年 Qian Dong. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var filteredTodos:[TodoModel] = []


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func dateFromString(dateStr: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateStr)
        return date!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [TodoModel(id: "1" , image: "child-selected", title:"1.去游乐场", date: NSDate()), TodoModel(id: "2" , image: "shopping-cart-selected", title:"2.购物", date: dateFromString("2015-11-05")), TodoModel(id: "3" , image: "phone-selected", title:"3.打电话", date: dateFromString("2015-11-06")), TodoModel(id: "4" , image: "travel-selected", title:"4.旅游", date: dateFromString("2015-11-07"))]
         navigationItem.leftBarButtonItem = editButtonItem()
        
         var contentOffset = tableView.contentOffset
         contentOffset.y += (searchDisplayController?.searchBar.frame.size.height)!
        tableView.contentOffset = contentOffset
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredTodos.count
        }
        return todos.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell")!
        var todo: TodoModel
        if tableView == searchDisplayController?.searchResultsTableView {
           todo = filteredTodos[indexPath.row]
        }else{
           todo = todos[indexPath.row]
        }
        
        
        let image = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        let date = cell.viewWithTag(103) as! UILabel
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
//        let locale = NSLocale.currentLocale()
        let dateFormatter = NSDateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        
        date.text = dateFormatter.stringFromDate(todo.date)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    // MARK - UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        }
    }

    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        print("closed")
        tableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            let vc = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            if indexPath != nil  {
                vc.todo = todos[indexPath!.row]
            }
        }
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return editing
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
         let todo = todos.removeAtIndex(sourceIndexPath.row)
         todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        
        filteredTodos = todos.filter(){
            $0.title.rangeOfString(searchString!) != nil
        }
        return true
    
    }
}

