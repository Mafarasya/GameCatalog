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
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        
        label.text = "Popular Games"
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    var games: [Game] = []
    
    struct Cells {
        static let gameCell = "GameCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .white
        view.backgroundColor = UIColor(named: "background")
        
        games = fetchData()
        
        configureTitleLabel()
        configureTableView()
        
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 132
        
        tableView.register(GameCell.self, forCellReuseIdentifier: Cells.gameCell)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "background")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension PopularGameListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.gameCell) as! GameCell
        let game = games[indexPath.row]
        
        cell.set(game: game)
        
        return cell
    }
}

// TEST DUMMY DATA
extension PopularGameListVC {
    
    func fetchData() -> [Game] {
        let game1 = Game(image: UIImage(named: "myPhoto")!, gameTitle: "GTA San Andreas", releaseDate: "1992", rating: "4.5")
        let game2 = Game(image: UIImage(named: "myPhoto")!, gameTitle: "The Legend of Zelda: Breath of the Wild", releaseDate: "2017", rating: "4.9")
        let game3 = Game(image: UIImage(named: "myPhoto")!, gameTitle: "Red Dead Redemption 2", releaseDate: "2018", rating: "4.8")
        let game4 = Game(image: UIImage(named: "myPhoto")!, gameTitle: "The Witcher 3: Wild Hunt", releaseDate: "2015", rating: "4.9")
        let game5 = Game(image: UIImage(named: "myPhoto")!, gameTitle: "Minecraft", releaseDate: "2011", rating: "4.7")
        
        return [game1, game2, game3, game4, game5]
    }
    
}


#Preview {
    PopularGameListVC()
}

