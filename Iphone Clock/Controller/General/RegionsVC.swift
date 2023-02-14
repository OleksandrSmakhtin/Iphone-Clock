//
//  RegionsVCViewController.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

protocol UpdateTimeDelegate {
    func updateTableTime(time: WorldTime)
}


class RegionsVC: UIViewController {
    
    var delegate: UpdateTimeDelegate?
    
    //MARK: - Data
    let timeZoneArray = WorldTimeData.shared.timeZone()
    
    
    //MARK: - UI objects
    // regions table
    private let regionsTable: UITableView = {
        let table = UITableView()
        table.register(RegionTableViewCell.self, forCellReuseIdentifier: RegionTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // choose city lbl
    private let chooseCityLbl: UILabel = {
        let label = UILabel()
        label.text = "Обрати місто"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // search bar
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Пошук"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // cancel btn
    private let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Скасувати", for: .normal)
        btn.setTitleColor(UIColor.systemOrange, for: .normal)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        
        // delegates
        applyDelegates()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(chooseCityLbl)
        view.addSubview(searchBar)
        view.addSubview(cancelBtn)
        view.addSubview(regionsTable)
    }
    
    
    //MARK: - Action for btns
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let chooseCityLblConstraints = [
            chooseCityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseCityLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(equalTo: chooseCityLbl.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: cancelBtn.leadingAnchor, constant: -1)
        ]
        
        let cancelBtnConstraints = [
            cancelBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            cancelBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        ]
        
        let regionsTableConstraints = [
            regionsTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            regionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            regionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            regionsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        
        NSLayoutConstraint.activate(chooseCityLblConstraints)
        NSLayoutConstraint.activate(searchBarConstraints)
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(regionsTableConstraints)
    }
    

}

//MARK: - UITableViewDelegate & DataSource
extension RegionsVC: UITableViewDelegate, UITableViewDataSource {
    
    // delegates
    private func applyDelegates() {
        regionsTable.delegate = self
        regionsTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneArray.count
    }
    
    // cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier) as? RegionTableViewCell else { return UITableViewCell()}
        
        let model = timeZoneArray[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let timeZone = timeZoneArray[indexPath.row]
        
        delegate?.updateTableTime(time: timeZone)
        
        dismiss(animated: true)
    }
    
    
}
