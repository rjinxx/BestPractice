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
        viewModel.delegate = self

        tableView.dataSource = viewModel
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel.loadData()
    }
    
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        viewModel.loadUpdateData()
    }
}

extension ViewController: ProfileViewModelDelegate {
    
    func didFinishUpdates() {
        tableView?.reloadData()
    }
}


