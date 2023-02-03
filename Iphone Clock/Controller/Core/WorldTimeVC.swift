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
    
    private let noTimeLbl: UILabel = {
        let label = UILabel()
        label.text = "Немає годинників"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        // apply constraints
        applyConstraints()
        
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
        view.addSubview(noTimeLbl)
        view.addSubview(worldTimeTable)
    }
    
    //MARK: - Configure NavBar
    private func configureNavigationBar() {
        // left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Корегувати", style: .done, target: self, action: #selector(editingMode))
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addTime))
        
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let noTimeLblConstraints = [
            noTimeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTimeLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(noTimeLblConstraints)
    }
    
    //MARK: - Actions for Navigation bar items
    // for rigth button
    @objc private func addTime() {
        let vc = RegionsVC()
        // apply delegate
        vc.delegate = self
        
        showDetailViewController(vc, sender: self)
    }
    
    // editing mode
    @objc private func editingMode() {
        
        guard times.count != 0 else { return }
        
        if worldTimeTable.isEditing {
            worldTimeTable.isEditing = false
            
            worldTimeTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Корегувати"
        } else {
            worldTimeTable.isEditing = true
            
            worldTimeTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Готово"
        }
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
        
        
        if times.count == 0 {
            worldTimeTable.isHidden = true
            noTimeLbl.isHidden = false
        } else {
            worldTimeTable.isHidden = false
            noTimeLbl.isHidden = true
        }
        
        
        return times.count
    }
    
    //cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldTimeTableCell.identifier) as? WorldTimeTableCell else { return UITableViewCell()}
        
        let model = times[indexPath.row]
        
        // hide time lbl when editing mode is on
        if tableView.isEditing {
            cell.isTimeLblHidden(hideStatus: true)
        } else {
            cell.isTimeLblHidden(hideStatus: false)
        }
        
        
        cell.configure(with: model)
        
        return cell
    }

    
    
    // move rows
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // table did move row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // swap values from old index to new index
        times.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    // title for deliting rows
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Видалити"
    }
    
    
    // delete action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.times.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
 
        } else {
            return
        }
        
    }
    
}
