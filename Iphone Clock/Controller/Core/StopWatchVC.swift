//
//  StopWatchVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class StopWatchVC: UIViewController {

    //MARK: - UI objects
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.text = "00:00,00"
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resetAndCircleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Круг", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let circleView_1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circleView_2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startStopBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
        button.setTitleColor(.green, for: .normal)
        //dynamic round corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(timeLbl)
        view.addSubview(resetAndCircleBtn)
        circleView_1.addSubview(startStopBtn)
        view.addSubview(circleView_1)
        //view.addSubview(startStopBtn)
    }

    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let timeLblConstraints = [
            timeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            
        ]
        
//        let resetAndCircleBtnConstraints = [
//
//        ]
//
        
        let circleView_1Constraints = [
            circleView_1.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 100),
            circleView_1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circleView_1.widthAnchor.constraint(equalToConstant: 80),
            circleView_1.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let startStopBtnConstraints = [
//            startStopBtn.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 30),
//            startStopBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            startStopBtn.widthAnchor.constraint(equalToConstant: 80),
//            startStopBtn.heightAnchor.constraint(equalToConstant: 80)
            startStopBtn.widthAnchor.constraint(equalToConstant: 77),
            startStopBtn.heightAnchor.constraint(equalToConstant: 77),
            startStopBtn.centerXAnchor.constraint(equalTo: circleView_1.centerXAnchor),
            startStopBtn.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor)
            
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        //NSLayoutConstraint.activate(resetAndCircleBtnConstraints)
        NSLayoutConstraint.activate(startStopBtnConstraints)
        NSLayoutConstraint.activate(circleView_1Constraints)
    }
}
