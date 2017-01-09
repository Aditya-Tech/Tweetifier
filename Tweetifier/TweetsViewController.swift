//
//  TweetsViewController.swift
//  Tweetifier
//
//  Created by Aditya Paruchuri on 1/7/17.
//  Copyright © 2017 Aditya Paruchuri. All rights reserved.
//

import UIKit

var selectedCategoryId: Int = -1
var items: [String : [String : [String]]] = [:]
var handles: [String] = []
var keywords: [[String]] = [[]]
var tweets: [[String]] = [[]]

let itemsObject = UserDefaults.standard.object(forKey: "diction")


class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var handlesTable: UITableView!
    
    
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
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell") as UITableViewCell!
   
        
        /*
         NOT NEEDED FOR NOW
        var cellLabel = ""
        
        if let tempLabel = handles[indexPath.count] as? String {
            cellLabel = tempLabel
        }
        
        cell.textLabel?.text = cellLabel
        */
        
        cell?.textLabel?.text = handles[indexPath.item] as? String
        
        return cell!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        if let tempItems = itemsObject as? [String : [String : [String]]] {
            items = tempItems
        }

        
        
        for (k, v) in items {
            handles.append(k)
            //print(handles)
            
            var kArr = [String]()
            
            for (i, j) in v {
                kArr.append(i)
            }
            
            keywords.append(kArr)
        }
        
        keywords.remove(at: 0)
        
        //keywords.dropFirst()
        //print(keywords)
        //print(items)
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedCategoryId = indexPath.row
        /*
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        print(handles[row])
        
        let kvc = self.storyboard?.instantiateViewController(withIdentifier: "kwVC") as! TweetsKeywordTableViewController
        
        self.navigationController?.pushViewController(kvc, animated: true) */
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        /*
        let destination = storyboard.instantiateViewController(withIdentifier: "kwVC") as! TweetsKeywordTableViewController
        navigationController?.pushViewController(destination, animated: true)
        */
        
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "kwVC") as! TweetsKeywordTableViewController
        self.present(nextViewController, animated:true, completion:nil)

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TweetsKeywordTableViewController
        
        vc.row = selectedCategoryId
   
    }
    

   

}
