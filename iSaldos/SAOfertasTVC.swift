//
//  SAOfertasTVC.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAOfertasTVC: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var menuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - Mostramos el menu lateral
        if revealViewController() != nil {
            menuBTN.target = revealViewController()
            menuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
