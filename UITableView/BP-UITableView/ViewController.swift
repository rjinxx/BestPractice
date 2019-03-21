//
//  ViewController.swift
//  BP-UITableView
//
//  Created by Ryan Jin on 2019/3/21.
//  Copyright © 2019 Perfect365, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }

        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }
}

