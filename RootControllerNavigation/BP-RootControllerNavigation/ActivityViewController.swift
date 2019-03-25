//
//  ActivityViewController.swift
//  BP-RootControllerNavigation
//
//  Created by Ryan Jin on 2019/3/25.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    static func storyboardInstance() -> ActivityViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? ActivityViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
