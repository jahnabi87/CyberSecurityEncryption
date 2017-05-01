//
//  GCDViewController.swift
//  CyberSecurityEncryption
//
//  Created by CHHABRA, JAHNABI on 9/5/16.
//  Copyright © 2016 Jahnabi Chhabra. All rights reserved.
//

//
//  FirstViewController.swift
//  CyberSecurityEncryption
//
//  Created by Jahnabi Chhabra on 04/09/16.
//  Copyright © 2016 Jahnabi Chhabra. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txt_Result: UITextField!
    @IBOutlet weak var txt_input_p: UITextField!
    @IBOutlet weak var txt_input_a: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_input_a.delegate = self
        txt_input_p.delegate = self
        txt_Result.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func calcGCDButtonTapped(sender: AnyObject) {
        
        
        let input_a:Int? = Int( String(self.txt_input_a.text!))
        let input_p:Int? = Int (self.txt_input_p.text!)
        
        
        if(input_p == nil || input_a == nil)
        {
            self.showInvalidALert()
            return
        }
        
        if(input_p != nil && input_a != nil)
        {
            let mod_a_p =   self.gcd(input_a!,input_p!)
            
            txt_Result.text = String(mod_a_p)
        }
        
    }
    
    
    func gcd(m: Int, _ n: Int) -> Int {
        var a = 0
        var b = max(m, n)
        var r = min(m, n)
        
        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }
    
    func showInvalidALert ()
    {
        
        let alertController = UIAlertController(title: "Invalid Input", message:
            "Please Enter Valid Input", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        //    let validString = NSCharacterSet(charactersInString: " !@#$%^&*()_+{}[]|\"<>,.~/:;?-=\\¥'£•¢")
        
        let maxLength = 10
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        
        if(newString.length > maxLength)
        {
            return false
        }
        let validString = NSCharacterSet(charactersInString: "-0123456789")
        // restrict special char in test field
        if (textField == self.txt_input_p || textField == self.txt_input_a)
        {
            if let range = string.rangeOfCharacterFromSet(validString.invertedSet)
            {
                print(range)
                return false
            }
        }
        
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}



