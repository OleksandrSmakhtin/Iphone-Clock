//
//  StopWatchVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class StopWatchVC: UIViewController {
    
    
    //MARK: - Timer
    private var timer = Timer()
    private var count = 0.0

    //MARK: - UI objects
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.text = "00:00,00"
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let circleView_1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = UIColor(named: "SpecialGreen")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circleView_2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startStopBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = UIColor(named: "SpecialGreen")
        button.setTitleColor(.systemGreen, for: .normal)
        // action
        button.addTarget(self, action: #selector(startStopAction), for: .touchUpInside)
        //dynamic round corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetAndCircleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Круг", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = .systemGray6
        // action
        button.addTarget(self, action: #selector(resetAndCircleAction), for: .touchUpInside)
        // dynamic corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Actions
    @objc private func startStopAction() {
        
        guard let title = startStopBtn.title(for: .normal) else { return }
        
        switch title {
        case "Старт":
            // ui changes
            startStopBtn.setTitle("Стоп", for: .normal)
            startStopBtn.setTitleColor(.systemRed, for: .normal)
            startStopBtn.backgroundColor = UIColor(named: "SpecialRed")
            circleView_1.backgroundColor = UIColor(named: "SpecialRed")
            circleView_2.backgroundColor = .systemGray4
            resetAndCircleBtn.backgroundColor = .systemGray4
            resetAndCircleBtn.setTitleColor(.white, for: .normal)
            
            // if resetBtn title == reset
            if resetAndCircleBtn.title(for: .normal) == "Скинути" {
                resetAndCircleBtn.backgroundColor = .systemGray4
                resetAndCircleBtn.setTitleColor(.white, for: .normal)
                resetAndCircleBtn.setTitle("Круг", for: .normal)
            }
            // logic
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            
        case "Стоп":
            // ui changes
            print("reset")
            circleView_1.backgroundColor = UIColor(named: "SpecialGreen")
            startStopBtn.setTitle("Старт", for: .normal)
            startStopBtn.backgroundColor = UIColor(named: "SpecialGreen")
            startStopBtn.setTitleColor(.systemGreen, for: .normal)
            resetAndCircleBtn.setTitle("Скинути", for: .normal)
            
        default:
            return
        }
    }
    
    @objc private func resetAndCircleAction() {
        //guard resetAndCircleBtn.backgroundColor != .systemGray6 else { return }
        guard let title = resetAndCircleBtn.title(for: .normal) else { return }
        
        switch title {
        case "Круг":
            print("Circle")
        case "Скинути":
            // ui changes
            resetAndCircleBtn.setTitle("Круг", for: .normal)
            resetAndCircleBtn.setTitleColor(.systemGray, for: .normal)
            resetAndCircleBtn.backgroundColor = .systemGray6
            circleView_2.backgroundColor = .systemGray6
            
            
        default:
            return
        }
    }
    
    @objc private func timerAction() {
//        count += 0.1
//        convertTimeToString()
//        print(count)
        convertTimeToString()
        milisec += 1
    }
    
    var min = 0
    var sec = 0
    var milisec = 0
    
    private func convertTimeToString() {
//        var timeString = ""
//        timeString += String(format: "%02d", (count % 3600) / 60)
//        timeString += ":"
//        timeString += String(format: "%02d", (count % 3600) % 60)
//        let second = (count % 3600) % 60
//        print("Seconds: \(second)")
//        let milisecond = second / 60
//        print("MiliSeconds: \(milisecond)")
//        timeString += ","
//        timeString += String(format: "%02d", ((count % 3600) % 60) / 60)
//        //timeString += ","
//        print(timeString)
        
        
        // works
        if milisec > 99 {
            milisec = 0
            sec += 1
            if sec > 59 {
                sec = 0
                min += 1
            }
        }
        
        
        
        var timeString = ""
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        timeString += ","
        timeString += String(format: "%02d", milisec)
        
        //timeString += String(format: "%02d", ((count % 3600) % 60) / 100)
        timeLbl.text = timeString
    }
    
    
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
        circleView_2.addSubview(resetAndCircleBtn)
        view.addSubview(circleView_2)
        //view.addSubview(startStopBtn)
    }

    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let timeLblConstraints = [
            timeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            
        ]
        
        let circleView_1Constraints = [
            circleView_1.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 100),
            circleView_1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circleView_1.widthAnchor.constraint(equalToConstant: 80),
            circleView_1.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let startStopBtnConstraints = [
            startStopBtn.widthAnchor.constraint(equalToConstant: 77),
            startStopBtn.heightAnchor.constraint(equalToConstant: 77),
            startStopBtn.centerXAnchor.constraint(equalTo: circleView_1.centerXAnchor),
            startStopBtn.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor)
        ]
        
        let cirleView_2Constraints = [
            circleView_2.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor),
            circleView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circleView_2.widthAnchor.constraint(equalToConstant: 80),
            circleView_2.heightAnchor.constraint(equalToConstant: 80)
        ]
        let resetAndCircleBtnConstraints = [
            resetAndCircleBtn.widthAnchor.constraint(equalToConstant: 77),
            resetAndCircleBtn.heightAnchor.constraint(equalToConstant: 77),
            resetAndCircleBtn.centerXAnchor.constraint(equalTo: circleView_2.centerXAnchor),
            resetAndCircleBtn.centerYAnchor.constraint(equalTo: circleView_2.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(startStopBtnConstraints)
        NSLayoutConstraint.activate(circleView_1Constraints)
        NSLayoutConstraint.activate(cirleView_2Constraints)
        NSLayoutConstraint.activate(resetAndCircleBtnConstraints)
    }
}
