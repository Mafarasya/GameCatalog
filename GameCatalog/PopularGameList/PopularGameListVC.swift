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
    
    private var games: [Game] = []
    
    struct Cells {
        static let gameCell = "GameCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .white
        view.backgroundColor = UIColor(named: "background")
                
        configureTitleLabel()
        configureTableView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task { await getGames() }

    }
    
    
    func getGames() async {
        let network: NetworkService = NetworkService()
        
        do {
            games = try await network.getGames()
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
        } catch {
            fatalError("Error: Connection Failed")
        }
    
    }
    
    fileprivate func startDownload(game: Game, indexPath: IndexPath) {
        let downloader: ImageDownloader = ImageDownloader()
        
        if game.state == .new {
            Task {
                do {
                    let image = try await downloader.downloadImage(url: game.backgroundImage)
                    game.state = .downloaded
                    game.image = image
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                } catch {
                    game.state = .failed
                    game.image = nil
                }
            }
        }
        
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
        
        if game.state == .new {
            cell.loadingIndicator.isHidden = false
            cell.loadingIndicator.startAnimating()
            startDownload(game: game, indexPath: indexPath)
        } else {
            cell.loadingIndicator.stopAnimating()
            cell.loadingIndicator.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = games[indexPath.row]
        let gameDetailVC: DetailPopularGameVC = DetailPopularGameVC()
        
        gameDetailVC.gameId = selectedGame.id
        
        navigationController?.pushViewController(gameDetailVC, animated: true)
        
    }
}

#Preview {
    PopularGameListVC()
}

