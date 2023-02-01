//
//  WorldTimeVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class WorldTimeVC: UIViewController {
    
    //MARK: - array of time zones
    var times = [WorldTime]()
    
    
    //MARK: - UI objects
    private let worldTimeTable: UITableView = {
        let table = UITableView()
        table.register(WorldTimeTableCell.self, forCellReuseIdentifier: WorldTimeTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        
        // change title
        title = "Світовий час"
        
        // configure nav bar
        configureNavigationBar()
        
        // add subviews
        addSubviews()
        
        // apply delegates
        applyDelegates()
        
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        worldTimeTable.frame = view.bounds
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(worldTimeTable)
    }
    
    //MARK: - Configure NavBar
    private func configureNavigationBar() {
        // left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Корегувати", style: .done, target: self, action: nil)
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addTime))
        
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Actions for Navigation bar items
    // for rigth button
    @objc private func addTime() {
        let vc = RegionsVC()
        // apply delegate
        vc.delegate = self
        showDetailViewController(vc, sender: self)
    }
}

//MARK: - UpdateTimeDelegate
extension WorldTimeVC: UpdateTimeDelegate {
    func updateTableTime(time: WorldTime) {
        times.append(time)
        worldTimeTable.reloadData()
    }
}

//MARK: - UITableViewDelegate & DataSource
extension WorldTimeVC: UITableViewDelegate, UITableViewDataSource {
    
    //delegates
    private func applyDelegates() {
        worldTimeTable.delegate = self
        worldTimeTable.dataSource = self
    }
    
    //number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    //cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldTimeTableCell.identifier) as? WorldTimeTableCell else { return UITableViewCell()}
        
        let model = times[indexPath.row]
        
        cell.configure(with: WorldTime(difference: model.difference, city: model.city, region: model.region, time: model.time))
        
        return cell
    }
}
