//
//  StopWatchVC.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 31.01.2023.
//

import UIKit

class StopWatchVC: UIViewController {
    
    //MARK: - Array
    private var circles = [Circle]()
    private var circlesCount = 0
    
    //MARK: - Timer
    private var timer = Timer()
    
    private var min = 0
    private var sec = 0
    private var milisec = 0

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
    
    private let circlesTable: UITableView = {
        let table = UITableView()
        table.register(CircleTableCell.self, forCellReuseIdentifier: CircleTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    
    //MARK: - Actions
    @objc private func startStopAction() {
        
        guard let title = startStopBtn.title(for: .normal) else { return }
        
        switch title {
        case "Старт":
            
            if circles.count == 0 {
                circlesCount += 1
                let model = Circle(circle: circlesCount, time: "00:00,00")
                circles.append(model)
                print("ADDED")
                circlesTable.reloadData()
            }
            
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
            // logic
            timer.invalidate()
            
        default:
            return
        }
    }
    
    @objc private func resetAndCircleAction() {
        guard let title = resetAndCircleBtn.title(for: .normal) else { return }
        
        switch title {
        case "Круг":
            
            circlesCount += 1
            
            
            
            let model = Circle(circle: circlesCount, time: "")
            circles.append(model)
            
//                circlesTable.beginUpdates()
//                circlesTable.moveRow(at: IndexPath(row: circles.count - 1, section: 0), to: IndexPath(row: 0, section: 0))
//                circlesTable.endUpdates()
            
            
        case "Скинути":
            // ui changes
            resetAndCircleBtn.setTitle("Круг", for: .normal)
            resetAndCircleBtn.setTitleColor(.systemGray, for: .normal)
            resetAndCircleBtn.backgroundColor = .systemGray6
            circleView_2.backgroundColor = .systemGray6
            // logic
            timeLbl.text = "00:00,00"
            min = 0
            sec = 0
            milisec = 0

        default:
            return
        }
    }
    
    @objc private func timerAction() {
                        
        let time = convertTimeToString()
            
        guard var model = circles.last else { return }
        model.updateTime(with: time)
        circles.removeLast()
        circles.append(model)
        circlesTable.reloadData()
        milisec += 1
    }
    
    
    private func convertTimeToString() -> String {
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
        
        timeLbl.text = timeString
        return timeString
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
        // apply delegates
        applyDelegates()
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(timeLbl)
        view.addSubview(resetAndCircleBtn)
        circleView_1.addSubview(startStopBtn)
        view.addSubview(circleView_1)
        circleView_2.addSubview(resetAndCircleBtn)
        view.addSubview(circleView_2)
        view.addSubview(circlesTable)
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
        
        let circlesTableConstraints = [
            circlesTable.topAnchor.constraint(equalTo: startStopBtn.bottomAnchor, constant: 30),
            circlesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circlesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circlesTable.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(startStopBtnConstraints)
        NSLayoutConstraint.activate(circleView_1Constraints)
        NSLayoutConstraint.activate(cirleView_2Constraints)
        NSLayoutConstraint.activate(resetAndCircleBtnConstraints)
        NSLayoutConstraint.activate(circlesTableConstraints)
    }
}


//MARK: - UITableViewDelegate & DataSource
extension StopWatchVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyDelegates() {
        circlesTable.delegate = self
        circlesTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableCell.identifier) as? CircleTableCell
        else { return UITableViewCell() }
        
        let model = circles[indexPath.row]
        
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
