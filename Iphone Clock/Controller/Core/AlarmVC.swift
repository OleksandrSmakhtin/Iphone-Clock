//
//  AlarmVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class AlarmVC: UIViewController {
    
    let sections = ["Сон|Пробудження","Інше"]
    
    var alarms = [Alarm]()
    
    //MARK: - UI objects
    private let alarmTable: UITableView = {
        let table = UITableView()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Корегувати", style: .done, target: self, action: nil)
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addAlarm))
    }
    
    //MARK: - Actions for Navigation bar items
    // for rigth button
    @objc private func addAlarm() {
        let vc = SetAlarmVC()
        // apply delegate
        vc.delegate = self
        showDetailViewController(vc, sender: self)
    }
}

//MARK: - SetAlarmDelegate
extension AlarmVC: SetAlarmDelegate {
    
    func getAlarm(alarm: Alarm) {
        alarms.append(alarm)
        alarmTable.reloadData()
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
    
    //will display heade view
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
            return alarms.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmartAlarmTableViewCell.identifier) as? SmartAlarmTableViewCell else { return UITableViewCell()}
            return cell

        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell()}

            let model = alarms[indexPath.row]
            cell.configure(with: model)
            
            return cell

        }
        
    }
    
    
    private func applyDelegates() {
        alarmTable.delegate = self
        alarmTable.dataSource = self
    }
    
    
    
    
}
