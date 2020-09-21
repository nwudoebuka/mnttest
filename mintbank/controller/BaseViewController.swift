//
//  BaseViewController.swift
//  Gogata
//
//  Created by Chukwuebuka Nwudo on 29/02/2020.
//  Copyright © 2020 Chukwuebuka Nwudo. All rights reserved.
//

import UIKit
import SwiftyJSON
class BaseViewController: UIViewController{
  
    var spinner:UIView!;
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // refresh()
        // Do any additional setup after loading the view.
    }
   
        func showLoading() {
            if(spinner != nil){
                hideLoading();
            }
            spinner = displaySpinner(onView: self.view)
        }
        
        func hideLoading() {
            removeSpinner(spinner: spinner ?? UIView())
        }
        
        
        func displaySpinner(onView: UIView) -> UIView {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
            
            let ai = UIActivityIndicatorView.init(style: .gray)
            //ai.hidesWhenStopped = true
            ai.startAnimating()
            ai.center = spinnerView.center
            
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            return spinnerView
        }
        
        func removeSpinner(spinner: UIView) {
            DispatchQueue.main.async {
                
                spinner.removeFromSuperview()
            }
        }
    func alertWithoutAction(_ title:String,_ msg:String){
           
           // Create the alert controller
           var msgs = msg
           if msg.isEmpty{
               msgs = "an error occured"
           }
           let alertController = UIAlertController(title: title, message: msgs, preferredStyle: .alert)
           
           // Create the actions
           let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
               UIAlertAction in
               
           }
           
           // Add the actions
           alertController.addAction(okAction)
           
           // Present the controller
           self.present(alertController, animated: true, completion: nil)
           
       }
   
}
