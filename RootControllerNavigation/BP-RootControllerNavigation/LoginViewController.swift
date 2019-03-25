//
//  LoginViewController.swift
//  BP-RootControllerNavigation
//
//  Created by Ryan Jin on 2019/3/25.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    static func storyboardInstance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? LoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(login))
        navigationItem.setLeftBarButton(loginButton, animated: true)
    }
    
    @objc private func login() {
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
