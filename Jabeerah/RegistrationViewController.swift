//
//  RegistrationViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/17/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var RePasswordTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(sender: AnyObject) {
        
        if NameTF.text == "" || EmailTF.text == "" || PasswordTF.text == "" || RePasswordTF == "" || PhoneTF.text == "" || CityTF.text == ""
        {
            let alert = UIAlertController(title: "عذرًا", message:"يجب عليك ملىء كل الحقول المطلوبة", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else {
            
            if PasswordTF.text != RePasswordTF.text {
                let alert = UIAlertController(title: "عذرًا", message:"كلمتي المرور غير متطابقتين", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
                
            } else {
                
                
                FIRAuth.auth()?.createUserWithEmail(EmailTF.text!, password: PasswordTF.text!, completion: { user, error in
                    print(error)
                    
                    if error != nil {
                        
                        let errorCode = FIRAuthErrorNameKey
                //I'm not sure about the syntax of errors but I'm gonna check and edit them!
                        switch errorCode {
                        case "FIRAuthErrorCodeEmailAlreadyInUse":
                            let alert = UIAlertController(title: "عذرًا", message:"الإيميل مستخدم", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                        case "FIRAuthErrorCodeUserNotFound":
                            let alert = UIAlertController(title: "عذرًا", message:"المستخدم غير موجود", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                        case "FIRAuthErrorCodeInvalidEmail":
                            let alert = UIAlertController(title: "عذرًا", message:"الإيميل غير صحيح", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                        case "FIRAuthErrorCodeNetworkError":
                            let alert = UIAlertController(title: "عذرًا", message:"خطأ في الاتصال بالانترنت", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                        default:
                            let alert = UIAlertController(title: "عذرًا", message:"خطأ غير معروف", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            
                            
                           
                            
                        }
                        
                        
                    } else {
                        
                        FIRAuth.auth()?.signInWithEmail(self.EmailTF.text!, password: self.PasswordTF.text!, completion: { (user: FIRUser?, error: NSError?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                
                               self.ref.child("UserProfile").child(user!.uid).setValue([
                                    "email": self.EmailTF.text!,
                                    "name" : self.NameTF.text!,
                                    "phone": self.PhoneTF.text!,
                                    "city" : self.CityTF.text!,
                                    ])
                                print("Sucess")
                              //  self.performSegueWithIdentifier("SignUp", sender: nil)
                                
                            }
                        })
                        
                    } //else
                })
                
            } //Big else
            
            
        } //Big Big else
    }
    
    
    }//end of



