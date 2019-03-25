//
//  RootViewController.swift
//  BP-RootControllerNavigation
//
//  Created by Ryan Jin on 2019/3/25.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var current: UIViewController

    init() {
        current = SplashViewController.storyboardInstance()!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        current = SplashViewController.storyboardInstance()!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChild(current)
        /**
         * - If we skip this line, the viewController will still be aligned properly in the most cases,
         * - but it can cause issues when the frame is changed.
         * - For example, when the in-call status bar is toggled, the top ViewController will not react to the new frame.
         */
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showLoginScreen() {
        
        let new = UINavigationController(rootViewController: LoginViewController.storyboardInstance()!)
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }

    func switchToLogout() {
        let loginViewController = LoginViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }

    func switchToMainScreen() {
        let mainViewController = MainViewController.storyboardInstance()!
        let mainScreen = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: mainScreen)
    }

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current,
                   to: new,
                   duration: 0.3,
                   options: [.transitionFlipFromLeft, .curveEaseOut],
                   animations: {}) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }

    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
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
