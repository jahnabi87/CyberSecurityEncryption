//
//  RSAEncryptionViewController.swift
//  CyberSecurityEncryption
//
//  Created by CHHABRA, JAHNABI on 9/12/16.
//  Copyright © 2016 Jahnabi Chhabra. All rights reserved.
//

import Foundation
import UIKit
import BigInt

/*
 a-97
 z-122
 .-46
 -32
 ?-63
 */

class RSAEncryptionViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtFld_decryptd: UITextField!
    @IBOutlet weak var txtFld_b: UITextField!
    @IBOutlet weak var txtFld_input: UITextField!
    @IBOutlet weak var txtFld_a: UITextField!
    
    @IBOutlet weak var txtFld_enryptd: UITextField!
    
    var characterMapping = [Character: Int]()
    var inverseMapping = [Int: Character]()
    
    var encryptedString : String = String()
    var decryptedString : String = String()
    
    var modifiedArray : Array<Int> = Array()
    
    var dVar : Int = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        txtFld_enryptd.userInteractionEnabled = false
//        txtFld_input.userInteractionEnabled = false
        txtFld_decryptd.userInteractionEnabled = false
        
        txtFld_input.delegate = self
        txtFld_a.delegate = self
        txtFld_b.delegate = self
        
        characterMapping = ["a": 1,"b": 2,"c": 3,"d": 4,"e": 5,"f": 6,"g": 7,"h": 8,"i": 9,"j": 10,"k": 11,"l": 12,"m": 13,"n": 14,"o": 15,"p": 16,"q": 17,"r": 18,"s": 19,"t": 20,"u": 21,"v": 22,"w": 23,"x": 24,"y": 25,"z": 26," ": 27,".": 28,"?": 29]
        
        inverseMapping = [1 :"a",2 :"b",3: "c",4: "d",5: "e",6: "f",7: "g",8: "h",9: "i",10: "j",11: "k",12: "l",13: "m",14: "n",15: "o",16: "p",17: "q",18: "r",19 :"s",20: "t",21: "u",22: "v",23: "w",24: "x",25: "y",26: "z",27: " ",28: ".",29 : "?"]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func decrypt_btn_tapped(sender: AnyObject) {
        
        
        //(a-1(C-b))mod N
        //a-1 = apow N-2 mod N
        
        
//        let input_b:Int? = Int( (self.txtFld_b.text!))
//        let input_a:BigUInt? = BigUInt( (self.txtFld_a.text!))
        
        let input_a:Int? = Int( (self.txtFld_a.text!))
        let input_b:Int? = Int (self.txtFld_b.text!)
        
        
        let n = input_a!*input_b!
        //        let input_b:BigUInt? = BigUInt( (self.txtFld_b.text!))
//        let inv_mod_a_p: BigUInt =  self.inverseModulus(input_a!,29)
        decryptedString = ""
        for character in modifiedArray {
            print(character)
            
            
//            let mappedValue =  characterMapping[character]
            
            
            let mappedValueBigInt : BigUInt = BigUInt(character)
            let bigN : BigUInt = BigUInt(n)
            
            
            let modValueBig =   mappedValueBigInt.power(BigUInt(dVar), modulus: bigN)
            //            let mappedValue =  String(characterMapping[character]!)
//            let mappedValue =  characterMapping[character]
            
            //            let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue)! - input_b!)
//            let cMinusB = mappedValue!-input_b!
//            let invModStr:String = String(inv_mod_a_p)
            
//            let invMod :Int = Int(invModStr)!
            
            
            //            let inverseValue = inv_mod_a_p.multiplyByDigit(cMinusB)
            //              let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue)! - input_b!)
            //            let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue).subtract(input_b!))
            //            let finalModStr : String = String(inverseValue%29)
//            var finalMod : Int = (invMod * cMinusB)%29
            
//            if(finalMod<0)
//            {
//                finalMod = finalMod+29
//            }
            //
            ////            let modValue = ((mappedValue! * input_a!) + input_b!) % 29
            //
            
            
            let modValue = Int(String(modValueBig))
            
            let inversedCharacter: Character = inverseMapping[modValue!]!
            decryptedString.append(inversedCharacter)
            
            //            let s = String(character).unicodeScalars
            //let asciiValue = s[s.startIndex].value
            //            print("Valuee == \(s[s.startIndex].value)")
            
            print(modValue)
        }
        //
        //
        //
        //
        //        if(!(input_a>0 && input_a<input_p && (BigUInt.gcd(input_a!, input_p!)==1)))
        //        {
        //            self.showInvalidALert()
        //            return
        //        }
        //
        //        if(input_p != nil && input_a != nil)
        //        {
        //            let mod_a_p =   self.inverseModulus(input_a!,input_p!)
        //
        //            txt_Result.text = String(mod_a_p)
        //        }
        //
        //
        //
        self.txtFld_decryptd.text = decryptedString
        print("Decrypted string == \(decryptedString)")
        
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
    
    
    func inverseModulus(a:BigUInt, _ p:BigUInt ) -> BigUInt {
        
        let result = a.inverse(p)
        return result!
    }
    
    
    func showInvalidALert ()
    {
        
        let alertController = UIAlertController(title: "Invalid Input", message:
            "Enter prime numbers", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    func is_prime(n: Int) -> Bool {
        if n <= 1 {
            return false
        }
        if n <= 3 {
            return true
        }
        var i = 2
        while i*i <= n {
            if n % i == 0 {
                return false
            }
            i = i + 1
        }
        return true
    }
    @IBAction func encrypt_btn_tapped(sender: AnyObject) {
        
        let inputString = txtFld_input.text!
        let input_a:Int? = Int( (self.txtFld_a.text!))
        let input_b:Int? = Int (self.txtFld_b.text!)
        
        if(!(self.is_prime(input_a!) && self.is_prime(input_b!)))
        {
        self.showInvalidALert()
            return
        }
        
        
        let n = input_a!*input_b!
        let phiN = (input_a!-1)*(input_b!-1)
        
        let dinititalRange = (max(input_a!, input_b!)+1)
        let dFinalRange = n-1
        
        dVar = dinititalRange
       
        while dVar<dFinalRange {
        
            if(self.gcd(dVar, phiN)==1)
            {
            break
            }
            else
            {
            dVar = dVar+1
            }
        }
        
//        dVar = 5
        
        let dBig:BigUInt = BigUInt(dVar)
        let phiNBig : BigUInt = BigUInt(phiN)
        
        let dInverse = self.inverseModulus(dBig, phiNBig)
        
        let eVAr = Int(String(dInverse))
        
        
        
        
        
    
        // a*p +b mod N
        encryptedString = ""
        modifiedArray.removeAll()
        
        for character in inputString.characters {
            print(character)
            
            let mappedValue =  characterMapping[character]
            
            
            let mappedValueBigInt : BigUInt = BigUInt(mappedValue!)
            let bigN : BigUInt = BigUInt(n)
            
            
      let modValueBig =   mappedValueBigInt.power(dInverse, modulus: bigN)
            
            let modValue = String(modValueBig)
            let modValueInt = Int(String(modValueBig))
//            let modValue = ((mappedValue! * input_a!) + input_b!) % 29
            modifiedArray.append(modValueInt!)
//            let inversedCharacter: Character = inverseMapping[modValue!]!
            encryptedString = encryptedString+modValue
            
            //            let s = String(character).unicodeScalars
            //let asciiValue = s[s.startIndex].value
            //            print("Valuee == \(s[s.startIndex].value)")
            
            print(mappedValue!)
        }
        
        print("Encrypted string == \(encryptedString)")
        print("Encryped Array == \(modifiedArray)")
        
        self.txtFld_enryptd.text = encryptedString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        //    let validString = NSCharacterSet(charactersInString: " !@#$%^&*()_+{}[]|\"<>,.~/:;?-=\\¥'£•¢")
        
        ////        let maxLength = 10
        //        let currentString: NSString = textField.text!
        //        let newString: NSString =
        //            currentString.stringByReplacingCharactersInRange(range, withString: string)
        
        var validString = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyz .?")
        // restrict special char in test field
        if (textField == self.txtFld_input)
        {
            if let range = string.rangeOfCharacterFromSet(validString.invertedSet)
            {
                print(range)
                return false
            }
        }
        
        
        
        if (textField == self.txtFld_a || textField == self.txtFld_b)
        {
            validString = NSCharacterSet(charactersInString: "0123456789")
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

