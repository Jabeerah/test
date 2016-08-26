//
//  UIViewController+Extension.swift
//  Jabeerah
//
//  Created by albendari fawaz on 8/22/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: okTitle, style: .Cancel, handler: okHandler))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

