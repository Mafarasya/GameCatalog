//
//  ViewController.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 10/05/24.
//

import UIKit
import SwiftUI

class PopularGameListVC: UIViewController {

    let tableView = UITableView()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
    }
}

#Preview {
    PopularGameListVC()
}

