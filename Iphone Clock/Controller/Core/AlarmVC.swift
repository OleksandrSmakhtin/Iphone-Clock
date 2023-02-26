//
//  AlarmVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class AlarmVC: UIViewController {
    
    let sections = ["Сон|Пробудження","Інше"]
    
    //var alarms = [Alarm]()
    private var coreAlarms = [AlarmCoreData]()
    
    //MARK: - UI objects
    private let alarmTable: UITableView = {
        let table = UITableView()
        table.allowsSelectionDuringEditing = true
        table.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        table.register(SmartAlarmTableViewCell.self, forCellReuseIdentifier: SmartAlarmTableViewCell.identifier)
        return table
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply delegates
        applyDelegates()
        // fetch core data
        fetchAlarms()
    }
    
    //MARK: - viedDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        alarmTable.frame = view.bounds
    }
    
    
    //MARK: - add subviews
    private func addSubviews() {
        view.addSubview(alarmTable)
    }
    
    
    //MARK: - configure NavBar
    private func configureNavBar() {
        title = "Будильник"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
        
        // left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Корегувати", style: .done, target: self, action: #selector(editingMode))
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addAlarm))
    }
    
    //MARK: - Actions for Navigation bar items
    // for rigth button
    @objc private func addAlarm() {
        let vc = SetAlarmVC()
        // apply delegate
        vc.delegate = self
        //UINavigationController(rootViewController: vc)
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
        //showDetailViewController(vc, sender: self)
    }
    
    // editing mode
    @objc private func editingMode() {
        //guard alarms.count != 0 else { return }
        guard coreAlarms.count != 0 else { return }
        
        if alarmTable.isEditing {
            alarmTable.isEditing = false
            
            alarmTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Корегувати"
        } else {
            alarmTable.isEditing = true
            
            alarmTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Готово"
        }
    }
}

//MARK: - SetAlarmDelegate
extension AlarmVC: SetAlarmDelegate {
    
    func getAlarm(alarm: Alarm) {
        //alarms.append(alarm)
        DataPersistenceManager.shared.addAlarm(with: alarm)
        fetchAlarms()
        //alarmTable.reloadData()
    }
    
    //MARK: - Fetch core data
    func fetchAlarms() {
        DataPersistenceManager.shared.fetchAlarms { result in
            switch result {
            case .success(let alarms):
                self.coreAlarms = alarms
                DispatchQueue.main.async {
                    self.alarmTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Delete data
    func deleteData(model: AlarmCoreData) {
        DataPersistenceManager.shared.deleteAlarm(with: model) { result in
            
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
extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // title for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //will display header view
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        header.textLabel?.textColor = .white
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 300, height: header.bounds.height)
        
    }
    
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return /*alarms.count*/ coreAlarms.count
        }
    }
    
    // can edit rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // can't edit rows at section 1 (index 0)
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    // title for delete btn
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Видалити"
    }
    
    // editing styles
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            deleteData(model: coreAlarms[indexPath.row])
            
            self.coreAlarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
//            self.alarms.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            // using dispatch queue to set editing mode to false after all deleting proccesses will end
            if /*self.alarms.count*/ self.coreAlarms.count == 0 {
                DispatchQueue.main.async {
                    self.alarmTable.isEditing = false
                    self.navigationItem.leftBarButtonItem?.title = "Корегувати"
                }
            }
            
        default:
            return
        }
        
        
    }
    
    
    
    // cell for at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmartAlarmTableViewCell.identifier) as? SmartAlarmTableViewCell else { return UITableViewCell()}
            return cell

        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell()}

            //let model = alarms[indexPath.row]
            let model = coreAlarms[indexPath.row]
            
            
            
            // hiding switch when editing mode is on and add accessoryType
            if tableView.isEditing {
                cell.isSwitchHidden(hideStatus: true)
                cell.editingAccessoryType = .disclosureIndicator
                
            } else {
                cell.isSwitchHidden(hideStatus: false)
            }
            
            cell.configure(with: model)
            
            
            return cell
        }
    }
    
    
    // delegates
    private func applyDelegates() {
        alarmTable.delegate = self
        alarmTable.dataSource = self
    }
}
