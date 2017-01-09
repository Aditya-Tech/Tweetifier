//
//  TweetsViewController.swift
//  Tweetifier
//
//  Created by Aditya Paruchuri on 1/7/17.
//  Copyright © 2017 Aditya Paruchuri. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var handlesTable: UITableView!
    var items: [String : [String : [String]]] = [:]
    var handles: [String] = []
    var keywords: [[String]] = [[]]
    var tweets: [[String]] = [[]]
    
    struct tableObjects{
        var handleObjs = [String]()
        var keyObjs = [[String]]()
    }
    
    var objectArr = [tableObjects]()
    
    @available(iOS 2.0, *)
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return handles.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let forDelete = handles[indexPath.row]
            
            handles.remove(at: indexPath.row)
            items[forDelete] = nil
            
            handlesTable.reloadData()
            
            UserDefaults.standard.set(items, forKey: "diction")
        }
        
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    
    @IBAction func handleSwitch(_ sender: Any) {
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        //var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        
        
        /*
         NOT NEEDED
        var cellLabel = ""
        
        if let tempLabel = handles[indexPath.count] as? String {
            cellLabel = tempLabel
        }
        
        cell.textLabel?.text = cellLabel
        */
        
        cell.textLabel?.text = handles[indexPath.item] as? String
        
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.

        let itemsObject = UserDefaults.standard.object(forKey: "diction")
        
        if let tempItems = itemsObject as? [String : [String : [String]]] {
            items = tempItems
        }
        
        for (k, v) in items {
            handles.append(k)
            print(handles)
            
            var kArr = [String]()
            
            for (i, j) in v {
                kArr.append(i)
            }
            
            keywords.append(kArr)
        }
        
        keywords.dropFirst()
        
        objectArr = [tableObjects(handleObjs: handles, keyObjs: keywords)]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
