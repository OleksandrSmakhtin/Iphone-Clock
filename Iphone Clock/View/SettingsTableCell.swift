//
//  SettingsTableCell.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 05.02.2023.
//

import UIKit

class SettingsTableCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "SettingsTableCell"
        
    //MARK: - UI objects
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let propertyLbl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.tintColor = .systemOrange
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let propertySwitch: UISwitch = {
        let uiSwicth = UISwitch()
        uiSwicth.translatesAutoresizingMaskIntoConstraints = false
        return uiSwicth
    }()
    
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layer.backgroundColor = UIColor.clear.cgColor
        //contentView.backgroundColor = .clear
        
        contentView.layer.cornerRadius = 10
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
        contentView.addSubview(titleLbl)
        contentView.addSubview(propertyLbl)
        contentView.addSubview(textField)
        contentView.addSubview(propertySwitch)

        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        // title lbl constraints
        let titleLblConstraints = [
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let propertyLblConstraints = [
            propertyLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            propertyLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let textFieldConstraints = [
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10)
        ]
        
        let propertySwitchConstraints = [
            propertySwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            propertySwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(propertyLblConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(propertySwitchConstraints)
        
    }
    
    
    //MARK: - Configure cell
    public func configure(with model: Setting) {
        
        titleLbl.text = model.title
        
        switch model.property {
        case .label:
            propertyLbl.text = model.propertyValue
            propertyLbl.isHidden = false
            textField.isHidden = true
            propertySwitch.isHidden = true
            
        case .textField:
            textField.placeholder = model.propertyValue
            propertyLbl.isHidden = true
            textField.isHidden = false
            propertySwitch.isHidden = true
            
        case .uiSwitch:
            if model.propertyValue == "on" {
                propertySwitch.isOn = true
                
                propertyLbl.isHidden = true
                textField.isHidden = true
                propertySwitch.isHidden = false
            } else {
                propertySwitch.isOn = false
                
                propertyLbl.isHidden = true
                textField.isHidden = true
                propertySwitch.isHidden = false
            }
            
        }
        
        
    }

}
