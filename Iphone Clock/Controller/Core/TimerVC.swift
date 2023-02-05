//
//  TimerVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class TimerVC: UIViewController {
    
    private let hours = TimerData.shared.hours()
    private let minutes = TimerData.shared.minutes()
    private let seconds = TimerData.shared.seconds()
    
    
    private var timer = Timer()
    private var count = 0
    private var timerCounting = false
    
    
    //MARK: - UI objects
    private let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 70, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let endTimeLbl: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let bellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let hoursLbl: UILabel = {
        let label = UILabel()
        label.text = "г"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minutesLbl: UILabel = {
        let label = UILabel()
        label.text = "хв"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondsLbl: UILabel = {
        let label = UILabel()
        label.text = "с"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        //view.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 1.0)
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Відміна", for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = .systemGray6
        // action
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        // dynamic corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let startPauseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
        button.setTitleColor(.green, for: .normal)
        // action
        button.addTarget(self, action: #selector(startPauseAction), for: .touchUpInside)
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
        // apply delegates
        applyDelegates()

    }
    
    //MARK: - Btn actions
    @objc private func startPauseAction() {

        guard let title = startPauseBtn.title(for: .normal) else { return }
        
        switch title {
        case "Старт":
            // visabulity changing
            timePicker.isHidden = true
            timeLbl.isHidden = false
            // ui changes
            circleView_1.backgroundColor = UIColor(red: 0.51, green: 0.32, blue: 0.20, alpha: 0.255)
            startPauseBtn.backgroundColor = UIColor(red: 0.51, green: 0.32, blue: 0.20, alpha: 0.255)
            startPauseBtn.setTitleColor(.systemOrange, for: .normal)
            startPauseBtn.setTitle("Пауза", for: .normal)
            cancelBtn.setTitleColor(.white, for: .normal)
        case "Пауза":
            startPauseBtn.setTitle("Далі", for: .normal)
            circleView_1.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
            startPauseBtn.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
            startPauseBtn.setTitleColor(.green, for: .normal)
        case "Далі":
            circleView_1.backgroundColor = UIColor(red: 0.51, green: 0.32, blue: 0.20, alpha: 0.255)
            startPauseBtn.backgroundColor = UIColor(red: 0.51, green: 0.32, blue: 0.20, alpha: 0.255)
            startPauseBtn.setTitleColor(.systemOrange, for: .normal)
            startPauseBtn.setTitle("Пауза", for: .normal)
            cancelBtn.setTitleColor(.white, for: .normal)
        default:
            return
        }
        
    }
    
    @objc private func cancelAction() {
        
        cancelBtn.setTitleColor(.systemGray3, for: .normal)
        timeLbl.isHidden = true
        timePicker.isHidden = false
        startPauseBtn.setTitle("Старт", for: .normal)
        circleView_1.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
        startPauseBtn.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 0.5)
        startPauseBtn.setTitleColor(.green, for: .normal)
        
    }
    
    //MARK: - add subviews
    private func addSubviews() {
        // add picker it's and subviews
        view.addSubview(timePicker)
        timePicker.addSubview(hoursLbl)
        timePicker.addSubview(minutesLbl)
        timePicker.addSubview(secondsLbl)
        // add circle view 1 and it's subviews
        view.addSubview(circleView_1)
        circleView_1.addSubview(startPauseBtn)
        // add circle view 2 and it's subviews
        view.addSubview(circleView_2)
        circleView_2.addSubview(cancelBtn)
        // add time lbl
        view.addSubview(timeLbl)
//        view.addSubview(timeLbl)
//        view.addSubview(endTimeLbl)
//        view.addSubview(bellImage)
    }
    
    //MARK: - apply Constraints
    private func applyConstraints() {
        
        // time picker constraints
        let timePickerConstraints = [
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ]
        
        let hourLblConstraints = [
            hoursLbl.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            hoursLbl.leadingAnchor.constraint(equalTo: timePicker.leadingAnchor, constant: 75)
        ]
        
        let minutesLblConstraints = [
            minutesLbl.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            minutesLbl.leadingAnchor.constraint(equalTo: timePicker.leadingAnchor, constant: 175)
        ]
        
        let secondsLblConstraints = [
            secondsLbl.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            secondsLbl.trailingAnchor.constraint(equalTo: timePicker.trailingAnchor, constant: -30)
        ]
        
        // circle view 1 constraints
        let circleView_1Constraints = [
            circleView_1.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 100),
            circleView_1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circleView_1.widthAnchor.constraint(equalToConstant: 80),
            circleView_1.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let startStopBtnConstraints = [
            startPauseBtn.widthAnchor.constraint(equalToConstant: 77),
            startPauseBtn.heightAnchor.constraint(equalToConstant: 77),
            startPauseBtn.centerXAnchor.constraint(equalTo: circleView_1.centerXAnchor),
            startPauseBtn.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor)
            
        ]
        
        // circle view 2 constraints
        let cirleView_2Constraints = [
            circleView_2.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor),
            circleView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circleView_2.widthAnchor.constraint(equalToConstant: 80),
            circleView_2.heightAnchor.constraint(equalToConstant: 80)
        ]
        let cancelBtnConstrains = [
            cancelBtn.widthAnchor.constraint(equalToConstant: 77),
            cancelBtn.heightAnchor.constraint(equalToConstant: 77),
            cancelBtn.centerXAnchor.constraint(equalTo: circleView_2.centerXAnchor),
            cancelBtn.centerYAnchor.constraint(equalTo: circleView_2.centerYAnchor)
        ]
        
        // time lbl constraints
        let timeLblConstraints = [
            timeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ]
        
        // activate time picker constraints
        NSLayoutConstraint.activate(timePickerConstraints)
        NSLayoutConstraint.activate(hourLblConstraints)
        NSLayoutConstraint.activate(minutesLblConstraints)
        NSLayoutConstraint.activate(secondsLblConstraints)
        // activate circle view 1
        NSLayoutConstraint.activate(startStopBtnConstraints)
        NSLayoutConstraint.activate(circleView_1Constraints)
        // activate cirlce view 2
        NSLayoutConstraint.activate(cancelBtnConstrains)
        NSLayoutConstraint.activate(cirleView_2Constraints)
        // activate time lbl
        NSLayoutConstraint.activate(timeLblConstraints)
    }
    
}


//MARK: - UIPickerViewDelegate
extension TimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //delegates
    private func applyDelegates() {
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    // number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // number of rows in component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return seconds.count
            
        default:
            return 0
        }
    }
    
    
    
    
    // title for row at component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return "\(row)"
        default:
            return ""
        }
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//
//    }
    

    
    
}
