//
//  MelodyVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 27.02.2023.
//

import UIKit

class MelodyVC: UIViewController {
    
    //MARK: - Data
    private let melodies = MelodyData.shared.getMelodies()
    
    //MARK: - UI Objects
    private let melodyTable: UITableView = {
        let table = UITableView()
        table.layer.backgroundColor = UIColor.clear.cgColor
        //table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 10
        table.tintColor = .systemOrange
        table.sectionHeaderTopPadding = 50
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply table delegates
        applyTableDelegates()
    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(melodyTable)
    }
    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        
        let melodyTableConstraints = [
            melodyTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            melodyTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            melodyTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            melodyTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(melodyTableConstraints)
    }
    

}



//MARK: - UITableViewDelegate & DataSource
extension MelodyVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableDelegates() {
        melodyTable.delegate = self
        melodyTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Магазин"
        case 2:
            return "Пісні"
        case 3:
            return "Рінгтони"
        case 4:
            return ""
        default:
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 29
        case 4:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        
        let model = melodies[indexPath.row]
        let setting = Setting(title: model.title, property: .label, propertyValue: model.accessibilityTitle ?? "", accesorry: false)
        cell.configure(with: setting)
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
