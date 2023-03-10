//
//  RepeatVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 26.02.2023.
//

import UIKit

protocol RepeatDelegate {
    func getChosenRepeats(repeats: [Repeat])
}

class RepeatVC: UIViewController {
    
    //MARK: - Delegate
    var delegate: RepeatDelegate?
    
    //MARK: - Data
    private var repeats = RepeatData.shared.getRepeatData()

    //MARK: - UI objects
    private let repeatTable: UITableView = {
        let table = UITableView()
        table.layer.backgroundColor = UIColor.clear.cgColor
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 10
        table.tintColor = .systemOrange
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply table delegates
        applyTableDelegates()
    }
    
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getChosenRepeats(repeats: repeats)
    }
    
    //MARK: - init with chosen repeats
    public func configureWithChosenRepeats(repeats: [Repeat]?) {
        guard let chosenResults = repeats else { return }
        self.repeats = chosenResults
        print(chosenResults)
        repeatTable.reloadData()
    }
    
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(repeatTable)
    }

    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        // repeat table constraints
        let repeatTableConstraints = [
            repeatTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            repeatTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatTable.heightAnchor.constraint(equalToConstant: CGFloat(repeats.count * 50))
        ]
        
        NSLayoutConstraint.activate(repeatTableConstraints)
    }

}


//MARK: - UITableViewDelegate & DataSource
extension RepeatVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableDelegates() {
        repeatTable.delegate = self
        repeatTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repeats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        
        let repeatItem = repeats[indexPath.row]
        
        if repeatItem.isChosen {
            cell.accessoryType = .checkmark
        }
        
        let title = repeatItem.title
        let model = Setting(title: title, property: .label, propertyValue: "", accesorry: false)
        
        cell.configure(with: model)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let checkStatus = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        
        if checkStatus {
            // checked case
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            repeats[indexPath.row].isChosen = false
            
        } else {
            // unchecked case
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            repeats[indexPath.row].isChosen = true
        }
        
    }
    
}
