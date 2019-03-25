//
//  SplashViewController.swift
//  BP-RootControllerNavigation
//
//  Created by Ryan Jin on 2019/3/25.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static func storyboardInstance() -> SplashViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? SplashViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            
            self.activityIndicator.stopAnimating()
            
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                AppDelegate.shared.rootViewController.showLoginScreen()
            }
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
