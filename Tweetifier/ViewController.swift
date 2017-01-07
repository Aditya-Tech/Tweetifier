//
//  ViewController.swift
//  Tweetifier
//
//  Created by Aditya Paruchuri on 1/6/17.
//  Copyright © 2017 Aditya Paruchuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    var dict: [String: [String : [String]]] = [:]
    var dictForKeywords: [String: [String]] = [:]
    var dictForTweets: [String: [String]] = [:]
    
    func save() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(dictForKeywords, forKey: "kewo")
        userDefaults.set(dictForTweets, forKey: "twts")
    }
    
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var output: UILabel!
    
    @IBOutlet weak var deleteTweet: UITextField!
    @IBOutlet weak var deleteKeyword: UITextField!
    @IBOutlet weak var deleteHandle: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        var tweet = ""
        
        if (!handleExists()) {
            addHandle(han: handle.text!)
        }
        
        if (!keywordExists(kw: keyword.text!)) {
            addKeyword(kw: keyword.text!, han: handle.text!)
            tweet = returnTweet()
            output.text = tweet
            
            if (tweet != "Not found") {
                addTweet(tw: tweet, han: handle.text!, kw: keyword.text!)
            }
        } else {
            output.text = "This keyword is already stored."
        }
        
        
        print(dict)
        
        
    }
    
    @IBAction func tweetDelete(_ sender: Any) {
        let temp = dict[deleteHandle.text!]?[deleteKeyword.text!]!.filter {$0 != deleteTweet.text}
        dict[deleteHandle.text!]?[deleteKeyword.text!] = temp
        
        print(dict)
    }
    
    
    @IBAction func keywordDelete(_ sender: Any) {
        dict[handle.text!]?[keyword.text!] = nil
        
        print(dict)
    }
   
    
    @IBAction func handleDelete(_ sender: Any) {
        dict[deleteHandle.text!] = nil
        
        print(dict)
    }
    
    
    func returnTweet() -> String{
        let myURLString = "https://twitter.com/" + handle.text! + "/with_replies"
        
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
            
            if (result.lowercased().range(of: (keyword.text?.lowercased())!) != nil) {
                return result
                //addTweet(tw: result, han: handle.text!)
            }
            
        } catch let error {
            print("Error: \(error)")
        }
        
        return "Not found"

    }
    

}

