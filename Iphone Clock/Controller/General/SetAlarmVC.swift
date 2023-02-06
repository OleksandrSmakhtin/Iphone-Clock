//
//  SetAlarmVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 02.02.2023.
//

import UIKit
//MARK: - Protocol
protocol SetAlarmDelegate {
    func getAlarm(alarm: Alarm)
}

class SetAlarmVC: UIViewController {
    
    //MARK: - Data
    private let allHours = AlarmData.shared.hours()
    private let allMinutes = AlarmData.shared.minutes()
    
    private let settings = SettingsData.shared.getAlarmSettings()
    
    
    
    //MARK: - Delegate
    var delegate: SetAlarmDelegate?
    
    //MARK: - UI objects
    private let cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Скасувати", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(cancleAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let saveBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Зберегти", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addingLbl: UILabel = {
        let label = UILabel()
        label.text = "Додавання"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let settingsTable: UITableView = {
        let table = UITableView()
        table.layer.backgroundColor = UIColor.clear.cgColor
        table.isScrollEnabled = false
        //table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 10
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        return table
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyPickerViewDelegates()
        applyTableViewDelegates()

    }
    
    
    //MARK: - add subviews
    private func addSubviews() {
        view.addSubview(cancelBtn)
        view.addSubview(saveBtn)
        view.addSubview(addingLbl)
        view.addSubview(timePicker)
        view.addSubview(settingsTable)
    }
    
    //MARK: - Actions
    @objc private func saveAction() {
        let hour = allHours[timePicker.selectedRow(inComponent: 0)]
        let minute = allMinutes[timePicker.selectedRow(inComponent: 1)]
        
        
        let model = Alarm(hours: hour, minutes: minute, isOn: false)
        
        // send alarm to alarm vc with the help of delegation
        delegate?.getAlarm(alarm: model)
        dismiss(animated: true)
        print("\(hour):\(minute)")
    }
    
    @objc private func cancleAction() {
        dismiss(animated: true)
    }
    
    
    //MARK: - apply constraints
    private func applyConstraints() {
        
        let cancelBtnConstraints = [
            cancelBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]
        
        let addingLblConstraints = [
            addingLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addingLbl.centerYAnchor.constraint(equalTo: saveBtn.centerYAnchor)
        ]
        
        let saveBtnConstraints = [
            saveBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let timePickerConstraints = [
            timePicker.topAnchor.constraint(equalTo: addingLbl.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let settingsTableConstraints = [
            settingsTable.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 30),
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsTable.heightAnchor.constraint(equalToConstant: CGFloat(settings.count * 50)),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(addingLblConstraints)
        NSLayoutConstraint.activate(saveBtnConstraints)
        NSLayoutConstraint.activate(timePickerConstraints)
        NSLayoutConstraint.activate(settingsTableConstraints)
        
    }
 

}


//MARK: - UIPickerViewDelegate & DataSource
extension SetAlarmVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
        
    private func applyPickerViewDelegates() {
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return allHours.count
        } else {
            return allMinutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
            
        } else {
            
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
            
        }
    }
    
}


//MARK: - UITableViewDelegate & DataSource
extension SetAlarmVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableViewDelegates() {
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        
        let model = settings[indexPath.row]
        
        if model.accesorry {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
