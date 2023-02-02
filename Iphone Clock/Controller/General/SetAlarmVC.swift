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
    
    //MARK: - Arrays
    private let allHours = AlarmData.shared.hours()
    private let allMinutes = AlarmData.shared.minutes()
    
    
    //MARK: - Delegate
    var delegate: SetAlarmDelegate?
    
    //MARK: - UI objects
    private let cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Скачувати", for: .normal)
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
        applyDelegates()

    }
    
    
    //MARK: - add subviews
    private func addSubviews() {
        view.addSubview(cancelBtn)
        view.addSubview(saveBtn)
        view.addSubview(addingLbl)
        view.addSubview(timePicker)
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
        
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(addingLblConstraints)
        NSLayoutConstraint.activate(saveBtnConstraints)
        NSLayoutConstraint.activate(timePickerConstraints)
        
    }
 

}


//MARK: - UIPickerViewDelegate & DataSource
extension SetAlarmVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
        
    private func applyDelegates() {
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
