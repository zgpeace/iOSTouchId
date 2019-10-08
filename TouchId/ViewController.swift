//
//  ViewController.swift
//  TouchId
//
//  Created by zgpeace on 2019/10/8.
//  Copyright © 2019 HSBCNet. All rights reserved.
//

import UIKit
import SnapKit
import LocalAuthentication

class ViewController: UIViewController {
    
    var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addSubViews()
    }
    
    func addSubViews() {
        button = UIButton()
        self.view.addSubview(button!)
        
        button?.setTitle("Anthentication", for: .normal)
        button?.setTitleColor(.orange, for: .normal)
        button?.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        button!.snp.makeConstraints { (make) in
//            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func buttonClick() {
        print("233333..")
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                // 4
                if success {
                    self.showAlertController(message: "Touch ID Authentication Succeeded")
                } else {
                    self.showAlertController(message: "Touch ID Authentication Failed")
                }
            }
        } else {
            // 5
            showAlertController(message: "Touch ID not available")
        }
        
    }
    
    func showAlertController(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }


}

