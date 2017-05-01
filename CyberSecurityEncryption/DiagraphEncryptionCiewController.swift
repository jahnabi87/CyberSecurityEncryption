//
//  DiagraphEncryptionCiewController.swift
//  CyberSecurityEncryption
//
//  Created by CHHABRA, JAHNABI on 9/11/16.
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


extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}

class DiagraphEncryptionCiewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtFld_decryptd: UITextField!
    @IBOutlet weak var txtFld_input: UITextField!
    @IBOutlet weak var txtFld_a: UITextField!
    @IBOutlet weak var txtFld_b: UITextField!
    @IBOutlet weak var txtFld_c: UITextField!
    @IBOutlet weak var txtFld_d: UITextField!
    @IBOutlet weak var txtFld_enryptd: UITextField!
    
    var characterMapping = [Character: Int]()
    var inverseMapping = [Int: Character]()
    
    var determinant : Int  =  Int()
    var inverseDeterminant : Int  =  Int()
    
    
    
    var encryptedString : String = String()
    var decryptedString : String = String()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        txtFld_enryptd.userInteractionEnabled = false
//        txtFld_input.userInteractionEnabled = false
        txtFld_decryptd.userInteractionEnabled = false
        
        txtFld_input.delegate = self
        txtFld_a.delegate = self
        txtFld_b.delegate = self
        txtFld_c.delegate = self
        txtFld_d.delegate = self
        
        characterMapping = ["a": 0,"b": 1,"c": 2,"d": 3,"e": 4,"f": 5,"g": 6,"h": 7,"i": 8,"j": 9,"k": 10,"l": 11,"m": 12,"n": 13,"o": 14,"p": 15,"q": 16,"r": 17,"s": 18,"t": 19,"u": 20,"v": 21,"w": 22,"x": 23,"y": 24,"z": 25," ": 26,".": 27,"?": 28]
        
        inverseMapping = [0 :"a",1 :"b",2: "c",3: "d",4: "e",5: "f",6: "g",7: "h",8: "i",9: "j",10: "k",11: "l",12: "m",13: "n",14: "o",15: "p",16: "q",17: "r",18 :"s",19: "t",20: "u",21: "v",22: "w",23: "x",24: "y",25: "z",26: " ",27: ".",28 : "?"]
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func decrypt_btn_tapped(sender: AnyObject) {
        
        
        //(a-1(C-b))mod N
        //a-1 = apow N-2 mod N
        
        let input_a:Int? = Int( (self.txtFld_a.text!))
        let input_b:Int? = Int (self.txtFld_b.text!)
        let input_c:Int? = Int( (self.txtFld_c.text!))
        let input_d:Int? = Int (self.txtFld_d.text!)
       
        
        
        determinant = input_a!*input_d! - input_b!*input_c!
        
        while determinant<0 {
            determinant = determinant+29
        }
        let det = BigUInt(determinant)
        let invDet :BigUInt = self.inverseModulus(det, 29)
        let inverseDeterminant : Int = Int(String(invDet))!
        
        
        
        let input_a1 : Int? = input_d!*inverseDeterminant
        let input_b1 : Int? = -(input_b!)*inverseDeterminant
        let input_c1 : Int? = -(input_c!)*inverseDeterminant
        let input_d1 : Int? = input_a!*inverseDeterminant
        
        decryptedString = ""
        
//        let input_b:Int? = Int( (self.txtFld_b.text!))
//        let input_a:BigUInt? = BigUInt( (self.txtFld_a.text!))
//        //        let input_b:BigUInt? = BigUInt( (self.txtFld_b.text!))
//        let inv_mod_a_p: BigUInt =  self.inverseModulus(input_a!,29)
        var inputLength = encryptedString.characters.count
        if((inputLength%2)==0)
        {
            // do nothinh
        }
        else
        {
            inputLength+=1;
        }
        
        
        var iterationLength = 0
        
        while (iterationLength<(inputLength/2)) {
            
            
            let char1:Character = encryptedString[2*iterationLength]
            let char1Value : Int = characterMapping[char1]!
            var char2:Character
            var char2Value : Int
            
            
            if(encryptedString.characters.count > ((2*iterationLength)+1))
            {
                char2 = encryptedString[(2*iterationLength)+1]
                
                
            }
            else
            {
                char2 = " "
            }
            
            char2Value = characterMapping[char2]!
            
            var encryptC1Val = (((input_a1!*char1Value)+(input_b1!*char2Value))%29)
            if(encryptC1Val<0)
            {
            encryptC1Val += 29
            }
            
            //            let encryptC1est1 = (input_a!*char1Value)+(input_b!*char2Value)
            //            let modencrypt1 = encryptC1est1%27
            var encryptC2Val = (((input_c1! * char1Value)+(input_d1!*char2Value)))%29
            
            if(encryptC2Val<0)
            {
                encryptC2Val += 29
            }
            
            let encryptC1 = inverseMapping[encryptC1Val]
            let encryptC2 = inverseMapping[encryptC2Val]
            
            
            decryptedString.append(encryptC1!)
            decryptedString.append(encryptC2!)
            
            
            iterationLength+=1
            print("Char 1 =\(char1) && Char 2 = \(char2)")
        }

        
        self.txtFld_decryptd.text = decryptedString
        print("Decrypted string == \(decryptedString)")
        /*
        
        decryptedString = ""
        for character in encryptedString.characters {
            print(character)
            
            //            let mappedValue =  String(characterMapping[character]!)
            let mappedValue =  characterMapping[character]
            
            //            let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue)! - input_b!)
            let cMinusB = mappedValue!-input_b!
            let invModStr:String = String(inv_mod_a_p)
            
            let invMod :Int = Int(invModStr)!
            
            
            //            let inverseValue = inv_mod_a_p.multiplyByDigit(cMinusB)
            //              let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue)! - input_b!)
            //            let  inverseValue = inv_mod_a_p.multiply(BigUInt(mappedValue).subtract(input_b!))
            //            let finalModStr : String = String(inverseValue%29)
            var finalMod : Int = (invMod * cMinusB)%29
            
            if(finalMod<0)
            {
                finalMod = finalMod+29
            }
            //
            ////            let modValue = ((mappedValue! * input_a!) + input_b!) % 29
            //
            let inversedCharacter: Character = inverseMapping[finalMod]!
            decryptedString.append(inversedCharacter)
            
            //            let s = String(character).unicodeScalars
            //let asciiValue = s[s.startIndex].value
            //            print("Valuee == \(s[s.startIndex].value)")
            
            print(mappedValue)
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
 */
        
    }
    
    
    
    func showInvalidALert ()
    {
        
        let alertController = UIAlertController(title: "Invalid Input", message:
            "Enter positive values", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func inverseModulus(a:BigUInt, _ p:BigUInt ) -> BigUInt {
        
        let result = a.inverse(p)
        return result!
    }
    
    @IBAction func encrypt_btn_tapped(sender: AnyObject) {
        
        let inputString = txtFld_input.text!
        let input_a:Int? = Int( (self.txtFld_a.text!))
        let input_b:Int? = Int (self.txtFld_b.text!)
        let input_c:Int? = Int( (self.txtFld_c.text!))
        let input_d:Int? = Int (self.txtFld_d.text!)
        
        
        
        if(input_a<=0 || input_b<=0 || input_c<=0 || input_d<=0)
        {
        self.showInvalidALert()
            return
        }
        // a*p +b mod N
        encryptedString = ""
        
        
        determinant = input_a!*input_d! - input_b!*input_c!
        var inputLength = inputString.characters.count
        if((inputLength%2)==0)
        {
        // do nothinh
        }
        else
        {
            inputLength+=1;
        }
        
        
        var iterationLength = 0
        
        while (iterationLength<(inputLength/2)) {
        
            
            let char1:Character = inputString[2*iterationLength]
            let char1Value : Int = characterMapping[char1]!
            var char2:Character
            var char2Value : Int
            
        
            if(inputString.characters.count > ((2*iterationLength)+1))
            {
              char2 = inputString[(2*iterationLength)+1]
                
                
            }
            else
            {
                char2 = " "
            }
            
            char2Value = characterMapping[char2]!
        
            let encryptC1Val = (((input_a!*char1Value)+(input_b!*char2Value))%29)
            
//            let encryptC1est1 = (input_a!*char1Value)+(input_b!*char2Value)
//            let modencrypt1 = encryptC1est1%27
            let encryptC2Val = (((input_c! * char1Value)+(input_d!*char2Value)))%29
            
            let encryptC1 = inverseMapping[encryptC1Val]
            let encryptC2 = inverseMapping[encryptC2Val]
            
            
            encryptedString.append(encryptC1!)
            encryptedString.append(encryptC2!)
            
        
iterationLength+=1
            print("Char 1 =\(char1) && Char 2 = \(char2)")
        }
        
        /*
        for character in inputString.characters {
            print(character)
            
            let mappedValue =  characterMapping[character]
            let modValue = ((mappedValue! * input_a!) + input_b!) % 29
            
            let inversedCharacter: Character = inverseMapping[modValue]!
            encryptedString.append(inversedCharacter)
            
            //            let s = String(character).unicodeScalars
            //let asciiValue = s[s.startIndex].value
            //            print("Valuee == \(s[s.startIndex].value)")
            
            print(mappedValue!)
        }
        */
        print("Encrypted string == \(encryptedString)")
        
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
        if (textField == self.txtFld_a || textField == self.txtFld_b || textField == self.txtFld_c || textField == self.txtFld_d)
        {
            validString = NSCharacterSet(charactersInString: "1234567890")
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

