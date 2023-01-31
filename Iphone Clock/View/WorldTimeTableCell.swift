//
//  WorldTimeTableCell.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class WorldTimeTableCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "WorldTimeTableCell"
    
    //MARK: - UI objects
    // difference lbl
    private let differenceLbl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // city lbl
    private let cityLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // time lbl
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add subviews
        addSubviews()
        
        //apply constraints
        applyConstraints()
        
        
        
    }
    
    
    //MARK: - Required Init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(differenceLbl)
        contentView.addSubview(cityLbl)
        contentView.addSubview(timeLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let differenceLblConstraints = [
            differenceLbl.leadingAnchor.constraint(equalTo: cityLbl.leadingAnchor),
            differenceLbl.bottomAnchor.constraint(equalTo: cityLbl.topAnchor, constant: -5)
        ]
        
        let cityLblConstraints = [
            cityLbl.bottomAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: -10),
            cityLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ]
        
        let timeLblConstraints = [
            timeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            timeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(cityLblConstraints)
        NSLayoutConstraint.activate(differenceLblConstraints)
    }
    
    
    
    
    
    //MARK: - Configure cell
    public func configure(with model: WorldTime) {
        differenceLbl.text = model.difference
        cityLbl.text = model.city
        timeLbl.text = model.time
    }
    
    
    
    
    
    

}
