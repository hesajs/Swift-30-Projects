//
//  ViewController.swift
//  Stopwatch
//
//  Created by SaJesh Shrestha on 11/2/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

fileprivate let cellID = "LapCell"

class ViewController: UIViewController, UITableViewDelegate {
    
    //MARK:- Variables
    fileprivate var mainStopWatch = Stopwatch()
    fileprivate var lapStopWatch = Stopwatch()
    fileprivate var isPlay = false
    fileprivate var laps: [String] = []
    
    
    //MARK:- UI Components
    let uiLabelView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lapsTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.font = .systemFont(ofSize: 85, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lapTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.font = .systemFont(ofSize: 37, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playPauseButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(.systemGreen, for: .highlighted)
        btn.backgroundColor = #colorLiteral(red: 0.09749897569, green: 0.1993991435, blue: 0.1120369211, alpha: 0.8032427226)
        btn.layer.cornerRadius = 50
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lapResetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Lap", for: .normal)
        btn.setTitleColor(.systemGray6, for: .normal)
        btn.backgroundColor = .systemGray4
        btn.layer.cornerRadius = 50
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Stopwatch"
        layoutUI()
        
        lapsTableView.dataSource = self
        lapsTableView.delegate = self
        lapsTableView.register(LapTableViewCell.self, forCellReuseIdentifier: cellID)
        
        playPauseButton.addTarget(self, action: #selector(playPauseTimer), for: .touchUpInside)
        lapResetButton.addTarget(self, action: #selector(lapResetTimer), for: .touchUpInside)
    }
    
    
    //MARK:- OBJC Helpers
    @objc func playPauseTimer() {
        lapResetButton.isEnabled = true
        changeButton(lapResetButton, setTitle: "Lap", backgroundColor: .systemGray, setTitleColor: .init(white: 100/255, alpha: 0.8))
        
        if !isPlay {
            mainStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            
            isPlay = true
            changeButton(playPauseButton, setTitle: "Stop", backgroundColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), setTitleColor: .red)
        } else {
            mainStopWatch.timer.invalidate()
            lapStopWatch.timer.invalidate()
            isPlay = false
            changeButton(playPauseButton, setTitle: "Start", backgroundColor: #colorLiteral(red: 0.09749897569, green: 0.1993991435, blue: 0.1120369211, alpha: 0.8032427226), setTitleColor: .systemGreen)
            changeButton(lapResetButton, setTitle: "Reset", backgroundColor: .systemGray, setTitleColor: .init(white: 100/255, alpha: 0.8))
        }
    }
    
    @objc func lapResetTimer() {
        if !isPlay {
            lapResetButton.isEnabled = false
            changeButton(lapResetButton, setTitle: "Lap", backgroundColor: .systemGray4, setTitleColor: .systemGray2)
            resetMainTimer()
            resetLapTimer()
        } else {
            if let lapTimerLabel = lapTimerLabel.text {
                laps.append(lapTimerLabel)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopWatch, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopWatch, label: lapTimerLabel)
    }
    
    
    //MARK:- Private Helpers
    fileprivate func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter += 0.035
        
        var minutes = "\(Int(stopwatch.counter / 60))"
        if Int(stopwatch.counter / 60) < 10 {
            minutes = "0\(Int(stopwatch.counter / 60))"
        }
        
        var seconds = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopWatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopWatch, label: lapTimerLabel)
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00.00"
    }
    
    fileprivate func changeButton(_ button: UIButton, setTitle: String, backgroundColor: UIColor, setTitleColor: UIColor) {
        button.setTitle(setTitle, for: .normal)
        button.setTitleColor(setTitleColor, for: .highlighted)
        button.backgroundColor = backgroundColor
    }
    
    
    //MARK:- UILayout
    fileprivate func layoutUI() {
        view.addSubview(uiLabelView)
        view.addSubview(lapsTableView)
        uiLabelView.addSubview(lapTimerLabel)
        uiLabelView.addSubview(timerLabel)
        uiLabelView.addSubview(playPauseButton)
        uiLabelView.addSubview(lapResetButton)
        
        let btnHeight: CGFloat = 100
        
        NSLayoutConstraint.activate([
            uiLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            uiLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            uiLabelView.heightAnchor.constraint(equalToConstant: 400),
            
            lapsTableView.topAnchor.constraint(equalTo: uiLabelView.bottomAnchor),
            lapsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lapsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            lapsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            timerLabel.centerYAnchor.constraint(equalTo: uiLabelView.centerYAnchor, constant: -30),
            timerLabel.leadingAnchor.constraint(equalTo: uiLabelView.leadingAnchor, constant: 30),
            timerLabel.trailingAnchor.constraint(equalTo: uiLabelView.trailingAnchor, constant: -30),
            
            lapTimerLabel.trailingAnchor.constraint(equalTo: timerLabel.trailingAnchor),
            lapTimerLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor),
            lapTimerLabel.widthAnchor.constraint(equalToConstant: 150),
            
            lapResetButton.leadingAnchor.constraint(equalTo: uiLabelView.leadingAnchor, constant: 50),
            lapResetButton.bottomAnchor.constraint(equalTo: uiLabelView.bottomAnchor, constant: -30),
            lapResetButton.heightAnchor.constraint(equalToConstant: btnHeight),
            lapResetButton.widthAnchor.constraint(equalToConstant: btnHeight),
            
            playPauseButton.centerYAnchor.constraint(equalTo: lapResetButton.centerYAnchor),
            playPauseButton.trailingAnchor.constraint(equalTo: uiLabelView.trailingAnchor, constant: -50),
            playPauseButton.heightAnchor.constraint(equalToConstant: btnHeight),
            playPauseButton.widthAnchor.constraint(equalToConstant: btnHeight),
        ])
    }
}


//MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LapTableViewCell
        if let lapLabelNumber = cell.viewWithTag(11) as? UILabel {
            lapLabelNumber.text = "Lap \(laps.count - indexPath.row)"
        }
        if let lapLabelTimer = cell.viewWithTag(12) as? UILabel {
            lapLabelTimer.text = laps[laps.count - 1 - indexPath.row]
        }
        return cell
    }
}
