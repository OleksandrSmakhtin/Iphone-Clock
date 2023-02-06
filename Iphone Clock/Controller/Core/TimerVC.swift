//
//  TimerVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class TimerVC: UIViewController {
    
    //MARK: - Data
    private let hours = TimerData.shared.hours()
    private let minutes = TimerData.shared.minutes()
    private let seconds = TimerData.shared.seconds()
    
    private let settings = SettingsData.shared.getTimerSettings()
    
    //MARK: - Timer
    private var timer = Timer()
    private var countDown = 0
    private var timerCounting = false
    
    
    //MARK: - UI time picker
    private let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    //MARK: - UI time lbl
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 70, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - UI end time lbl
    private let endTimeLbl: UILabel = {
        let label = UILabel()
        return label
    }()
    //MARK: - UI bell image
    private let bellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    //MARK: - UI hours lbl
    private let hoursLbl: UILabel = {
        let label = UILabel()
        label.text = "г"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - UI minutes lbl
    private let minutesLbl: UILabel = {
        let label = UILabel()
        label.text = "хв"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - UI seconds lbl
    private let secondsLbl: UILabel = {
        let label = UILabel()
        label.text = "с"
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - UI circle view 1
    private let circleView_1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = UIColor(named: "SpecialGreen")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - UI circle view 2
    private let circleView_2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        //view.backgroundColor = UIColor(red: 0.10, green: 0.42, blue: 0.17, alpha: 1.0)
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - UI cancel btn
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
    //MARK: - UI start pause btn
    private let startPauseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = UIColor(named: "SpecialGreen")
        button.setTitleColor(.systemGreen, for: .normal)
        // action
        button.addTarget(self, action: #selector(startPauseAction), for: .touchUpInside)
        //dynamic round corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - UI gray view
    private let grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - UI settings table
    private let settingsTable: UITableView = {
        let table = UITableView()
        table.layer.backgroundColor = UIColor.clear.cgColor
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray6
        table.layer.cornerRadius = 10
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
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
        // apply delegates
        applyPickerViewDelegates()
        applyTableViewDelegates()

    }
    
    //MARK: - Convert to seconds
    private func convertToSeconds(hours: Int, minutes: Int, seconds: Int) -> Int {
        
        let result = ((hours * 60) * 60) + (minutes * 60) + seconds
        return result
    }
    
    //MARK: - Update time lbl with correct time format
    private func makeFullStringTime(seconds: Int) {
        var timeString = ""
        timeString += String(format: "%02d", seconds / 3600)
        timeString += ":"
        timeString += String(format: "%02d", (seconds % 3600) / 60)
        timeString += ":"
        timeString += String(format: "%02d", (seconds % 3600) % 60)
        timeLbl.text = timeString
        print(timeString)
    }
    
    //MARK: - Timer action
    @objc func countDownAction() {
        if countDown == 0 {
            timePicker.isHidden = false
            timeLbl.isHidden = true
            
            // change button title and color to reuse
            startPauseBtn.setTitle("Старт", for: .normal)
            startPauseBtn.backgroundColor = UIColor(named: "SpecialGreen")
            circleView_1.backgroundColor = UIColor(named: "SpecialGreen")
            startPauseBtn.setTitleColor(.systemGreen, for: .normal)
            cancelBtn.setTitleColor(.systemGray3, for: .normal)
            
            countDown = 0
            timer.invalidate()
        } else {
            countDown -= 1
            makeFullStringTime(seconds: countDown)
        }
    }
    
    //MARK: - Btn actions
    @objc private func startPauseAction() {

        guard let title = startPauseBtn.title(for: .normal) else { return }
        
        switch title {
        case "Старт":
            // logic
            let hours = timePicker.selectedRow(inComponent: 0)
            let minutes = timePicker.selectedRow(inComponent: 1)
            let seconds = timePicker.selectedRow(inComponent: 2)
            print("\(hours):\(minutes):\(seconds)")
            
            // accessability
            if hours == 0 && minutes == 0 && seconds == 0 {
                return
            }
            
            countDown = convertToSeconds(hours: hours, minutes: minutes, seconds: seconds)
            // change lbl instantly
            makeFullStringTime(seconds: countDown)
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
            print(countDown)
            
            
            // visabulity changing
            timePicker.isHidden = true
            timeLbl.isHidden = false
            // ui changes
            circleView_1.backgroundColor = UIColor(named: "SpecialYellow")
            startPauseBtn.backgroundColor = UIColor(named: "SpecialYellow")
            startPauseBtn.setTitleColor(.systemOrange, for: .normal)
            startPauseBtn.setTitle("Пауза", for: .normal)
            cancelBtn.setTitleColor(.white, for: .normal)
            
        case "Пауза":
            timer.invalidate()
            startPauseBtn.setTitle("Далі", for: .normal)
            circleView_1.backgroundColor = UIColor(named: "SpecialGreen")
            startPauseBtn.backgroundColor = UIColor(named: "SpecialGreen")
            startPauseBtn.setTitleColor(.systemGreen, for: .normal)
        case "Далі":
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
            
            circleView_1.backgroundColor = UIColor(named: "SpecialYellow")
            startPauseBtn.backgroundColor = UIColor(named: "SpecialYellow")
            startPauseBtn.setTitleColor(.systemOrange, for: .normal)
            startPauseBtn.setTitle("Пауза", for: .normal)
            cancelBtn.setTitleColor(.white, for: .normal)
        default:
            return
        }
        
    }
    
    @objc private func cancelAction() {
        
        // logic
        timer.invalidate()
        countDown = 0
        
        // ui changes
        cancelBtn.setTitleColor(.systemGray3, for: .normal)
        timeLbl.isHidden = true
        timePicker.isHidden = false
        startPauseBtn.setTitle("Старт", for: .normal)
        circleView_1.backgroundColor = UIColor(named: "SpecialGreen")
        startPauseBtn.backgroundColor = UIColor(named: "SpecialGreen")
        startPauseBtn.setTitleColor(.systemGreen, for: .normal)
        
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
        // add gray view
        //view.addSubview(grayView)
        // add settings table as subviews of gray view
        //grayView.addSubview(settingsTable)
        view.addSubview(settingsTable)
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
        let cancelBtnConstraints = [
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
        
        let settingsTableConstraints = [
            settingsTable.topAnchor.constraint(equalTo: startPauseBtn.bottomAnchor, constant: 30),
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsTable.heightAnchor.constraint(equalToConstant: CGFloat(settings.count * 50)),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(cirleView_2Constraints)
        // activate time lbl
        NSLayoutConstraint.activate(timeLblConstraints)
        // activate gray view constraints
        NSLayoutConstraint.activate(settingsTableConstraints)
        //NSLayoutConstraint.activate(grayViewConstraints)
    }
    
}


//MARK: - UIPickerViewDelegate
extension TimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //delegates
    private func applyPickerViewDelegates() {
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
}


//MARK: - UITableViewDelegate & DataSource
extension TimerVC: UITableViewDelegate, UITableViewDataSource {
    
    // apply delegates
    private func applyTableViewDelegates() {
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        
        let model = settings[indexPath.row]
        
        if model.accesorry {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.configure(with: model)
        

        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
