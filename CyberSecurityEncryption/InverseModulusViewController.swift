//
//  InverseModulus.swift
//  CyberSecurityEncryption
//
//  Created by CHHABRA, JAHNABI on 9/5/16.
//  Copyright © 2016 Jahnabi Chhabra. All rights reserved.
//

import UIKit
import BigInt

    
// Put this at file level anywhere in your project
infix operator ^^ { associativity left precedence 160 }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
class InverseModulusViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txt_Result: UITextField!
    @IBOutlet weak var txt_input_p: UITextField!
    @IBOutlet weak var txt_input_a: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_input_a.delegate = self
        txt_input_p.delegate = self
        txtField_check.userInteractionEnabled = false
        txt_Result.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtField_check: UITextField!
    
    @IBAction func calcInverseModuloButtonTapped(sender: AnyObject) {
        
        
        let input_a:BigUInt? = BigUInt(self.txt_input_a.text!)
        let input_p:BigUInt? = BigUInt (self.txt_input_p.text!)
        
        
         if(!(input_a>0 && input_a<input_p && (BigUInt.gcd(input_a!, input_p!)==1)))
        {
            txtField_check!.text = ""
            txt_Result!.text = ""
            self.showInvalidALert()
            return
        }
        
        if(input_p != nil && input_a != nil)
        {
            let mod_a_p =   self.inverseModulus(input_a!,input_p!)
            
            txt_Result.text = String(mod_a_p)
            [self .checkAXAInv()];
        }
        
    }


    func checkAXAInv ()
    {
        txtField_check!.text = "1"
        
    }
    
    func inverseModulus(a:BigUInt, _ p:BigUInt ) -> BigUInt {
        
//        var a1 = a
//        var b = 0;
//        var i  = p-2
//        
//        while i > 0 {
//            print("Value a1 == \(a1)");
//            b = a1%p
//            a1=b
//            i -= 1
//        }
//
//        return b
        
//        let result:BigUInt = a.power(p-2, modulus: p)
//        return result
        
        let result = a.inverse(p)
        return result!
    }
    
//    func gcd(m: Int, _ n: Int) -> Int {
//        var a = 0
//        var b = max(m, n)
//        var r = min(m, n)
//        
//        while r != 0 {
//            a = b
//            b = r
//            r = a % b
//        }
//        return b
//    }
    
    func showInvalidALert ()
    {
        
        let alertController = UIAlertController(title: "Invalid Input", message:
            "Please enter correct variables", preferredStyle: UIAlertControllerStyle.Alert)
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



