//
//  MelodyVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 27.02.2023.
//

import UIKit

class MelodyVC: UIViewController {
    
    //MARK: - UI Objects
    private let melodyTable: UITableView = {
        let table = UITableView()
        table.layer.backgroundColor = UIColor.clear.cgColor
        //table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 10
        table.tintColor = .systemOrange
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(melodyTable)
    }
    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        
    }
    

}



//MARK: - UITableViewDelegate & DataSource
extension MelodyVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
