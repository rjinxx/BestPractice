//
//  MainViewController.swift
//  BP-RootControllerNavigation
//
//  Created by Ryan Jin on 2019/3/25.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    static func storyboardInstance() -> MainViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? MainViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let logoutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
        
        let activityButton = UIBarButtonItem(title: "Activity", style: .plain, target: self, action: #selector(showActivityScreen))
        navigationItem.setRightBarButton(activityButton, animated: true)
    }
    
    @objc private func logout() {
        // clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        // navigate to the Main Screen
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    @objc func showActivityScreen(/*animated: Bool = true*/) {
        if let activityViewController = ActivityViewController.storyboardInstance() {
            navigationController?.pushViewController(activityViewController, animated: true)
        }
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
