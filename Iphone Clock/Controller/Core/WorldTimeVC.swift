//
//  WorldTimeVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit
import CoreData


class WorldTimeVC: UIViewController {
    
    //MARK: - array of time zones
    //var times = [WorldTime]()
    
    
    //MARK: - Core Data Array
    private var worldTimes = [WorldTimeCoreData]()

    
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
        
        // fetch saved time
        fetchTime()
        
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
        
        //guard times.count != 0 else { return }
        guard worldTimes.count != 0 else { return }
        
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
        
        DataPersistenceManager.shared.addWorldTime(with: time)
        fetchTime()
        //times.append(time)
        //worldTimeTable.reloadData()
    }
    
    //MARK: - fetch core data
    func fetchTime() {
        DataPersistenceManager.shared.fetchWorldTimes { result in
            
            switch result {
            case .success(let times):
                self.worldTimes = times
                DispatchQueue.main.async {
                    self.worldTimeTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Delete data
    func deleteData(model: WorldTimeCoreData) {
        DataPersistenceManager.shared.deleteWorldTime(with: model) { result in
            
            switch result {
            case .success():
                print("Deleted successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
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
        
        
        if /*times.count*/worldTimes.count == 0 {
            worldTimeTable.isHidden = true
            noTimeLbl.isHidden = false
        } else {
            worldTimeTable.isHidden = false
            noTimeLbl.isHidden = true
        }
        
        
        return /*times.count*/ worldTimes.count
    }
    
    //cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldTimeTableCell.identifier) as? WorldTimeTableCell else { return UITableViewCell()}
        
        //let model = times[indexPath.row]
        let model = worldTimes[indexPath.row]
        
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
        //times.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        worldTimes.swapAt(sourceIndexPath.row, destinationIndexPath.row)        
    }
    
    // title for deliting rows
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Видалити"
    }
    
    
    // delete action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            deleteData(model: worldTimes[indexPath.row])
            
            
            self.worldTimes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                
//            self.times.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // using dispatch queue to set editing mode to false after all deleting proccesses will end
            if /*self.times.count*/ self.worldTimes.count == 0 {
                
                DispatchQueue.main.async {
                    self.worldTimeTable.isEditing = false
                    self.navigationItem.leftBarButtonItem?.title = "Корегувати"
                }
            }
            
 
        } else {
            return
        }
        
    }
    
}
