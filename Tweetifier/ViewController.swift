//
//  ViewController.swift
//  Tweetifier
//
//  Created by Aditya Paruchuri on 1/6/17.
//  Copyright © 2017 Aditya Paruchuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var timer = Timer()
    //var timer2 = Timer()


    /*
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    */

    var dict: [String: [String : [String]]] = [:]
    
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var output: UILabel!
    
    @IBOutlet weak var deleteTweet: UITextField!
    @IBOutlet weak var deleteKeyword: UITextField!
    @IBOutlet weak var deleteHandle: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* example permanent storage setup

        // for Strings //
         
        //UserDefaults.standard.set("Aditya", forKey: "name")
        
        let nameObject = UserDefaults.standard.object(forKey: "name")
        
        if let name = nameObject as? String {
            print(name)
        }
        
        // for arrays //
        
        //let arr = [1, 2, 3, 4]
        
        //UserDefaults.standard.set(arr, forKey:"array")
        
        
        let arrayObject = UserDefaults.standard.object(forKey: "array")
        
        if let array = arrayObject as? NSArray {
            print(array)
        }
        
        */
      
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("updateLabelWhenTweetIsFound"), userInfo: nil, repeats: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDict(dict: [String : [String : [String]]]) {
        defaults.set(dict, forKey: "diction")
    }
    
    func getDict() -> [String : [String : [String]]] {
        if let temp = defaults.object(forKey: "diction") as? [String : [String : [String]]] {
            return temp
        }
        
        return dict
    }
    
    func tweetExists(tw: String) -> Bool {
        if (dict[handle.text!] != nil) {
            let tempArr = dict[handle.text!]?[keyword.text!]
            if (tempArr?.contains(tw))! {
                return true
            }
        }
        
        return false
    }
    
    
    func handleExists() -> Bool {
        if (dict[handle.text!] != nil) {
            return true
        }
        
        return false
    }
    
    func keywordExists(kw: String) -> Bool {
        if (dict[handle.text!] != nil) {
            let temp2 = dict[handle.text!]
            if (temp2?[kw] != nil) {
                return true
            }
        }
        
        return false
    }
    
    func addHandle(han: String) {
        dict[han] = [:]
    }
    
    func addTweet(tw: String, han: String, kw: String) {
        dict[han]?[kw]?.append(tw)
    }
    
    
    func addKeyword(kw: String, han: String) {
        dict[han]?[kw] = []
    }
    
    
    @IBAction func createNotification(_ sender: Any) {
        dict = getDict()
       /*
        
        let userObjects = UserDefaults.standard.object(forKey: "items1")
        
        
        var items: [String : [String : [String]]] = [:]
        
        if let tempItems = dict as? [String : [String : [String]]] {
            
            items = tempItems
            tweet = returnTweet(han: handle.text!, kw: keyword.text!)
            
            if !handleExists() {
                items[handle.text!] = [:]
            }
            
            if !keywordExists(kw: keyword.text!) {
                items[handle.text!]?[keyword.text!] = []
                if (tweet != "Not found") {
                    items[handle.text!]?[keyword.text!]?.append(tweet)
                }
                
            }
            
        } else {

            items[handle.text!]?[keyword.text!]?.append(tweet)
        }
        
    
        UserDefaults.standard.set(items, forKey: "items")
        
        handle.text = ""
        keyword.text = ""
        
        print(dict!)
        */
        
        
        //var tweet = ""
        
        
        if (!handleExists()) {
            addHandle(han: handle.text!)
        }
        
        if (!keywordExists(kw: keyword.text!)) {
            addKeyword(kw: keyword.text!, han: handle.text!)
            //tweet = returnTweet()
            //output.text = tweet
            
            //if (tweet != "Not found") {
                //addTweet(tw: tweet, han: handle.text!, kw: keyword.text!)
            //}
        }
    
        else {
            output.text = "This keyword is already stored."
        }
        
        setDict(dict: dict)
    }
    
    func updateLabelWhenTweetIsFound() {
        dict = getDict()
        for (k1, v1) in dict {
            for (k2, v2) in v1 {
                let twt = returnTweet(han: k1, kw: k2)
                if (twt == "Not found") {
                    break
                } else {
                    if (!(dict[k1]?[k2]?.contains(twt))!) {
                        dict[k1]?[k2]?.append(twt)
                        output.text = twt
                        //print(dict)
                    }
                    
                }
            }
        }
        
        setDict(dict: dict)
        //print("A second has passed")
    }
    
    @IBAction func tweetDelete(_ sender: Any) {
        let temp = dict[deleteHandle.text!]?[deleteKeyword.text!]!.filter {$0 != deleteTweet.text}
        dict[deleteHandle.text!]?[deleteKeyword.text!] = temp
        
        setDict(dict: dict)
    }
    
    /*
    func updateDict() {
        setDict(dict: dict)
    }
    */
    
    
    @IBAction func keywordDelete(_ sender: Any) {
        dict[handle.text!]?[keyword.text!] = nil
        
        setDict(dict: dict)
    }
   
    
    @IBAction func handleDelete(_ sender: Any) {
        dict[deleteHandle.text!] = nil
        setDict(dict: dict)
    }
    
    
    func returnTweet(han: String, kw: String) -> String{
        let myURLString = "https://twitter.com/" + han + "/with_replies"
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            exit(1)
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            
            let text = myHTMLString.replacingOccurrences(of: "\n", with: "")
            let range = text.range(of:"(?<=data-aria-label-part=\"0\">)[^~]+(?=</p></div>)", options:.regularExpression)
            let subtractRange = text.range(of:"(?<=</p></div>)[^~]+(?=</p></div>)", options:.regularExpression)
            
            var found = ""
            var subtractFound = ""
            var result = ""
            
            if range != nil {
                found = text.substring(with: range!)
                //print("found: \(found)")
                
            }
            
            if subtractRange != nil {
                subtractFound = text.substring(with: subtractRange!)
                //print("found: \(found)")
                
            }
            
            result = found.replacingOccurrences(of: subtractFound, with: "")
            
            if (result.lowercased().range(of: (kw.lowercased())) != nil) {
                return result
                //addTweet(tw: result, han: handle.text!)
            }
            
        } catch let error {
            print("Error: \(error)")
        }
        
        return "Not found"

    }
    
    @IBAction func printDictToConsole(_ sender: Any) {
        print(getDict())
    }

}

