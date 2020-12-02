//
//  ViewController.swift
//  2 Min App
//
//  Created by SaJesh Shrestha on 11/30/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK:- Constants
    let buttonWidth: CGFloat = 170
    let systemAlertSound: SystemSoundID = 1304
    
    
    //MARK:- Variables
    var timer = Stopwatch()
    var isStart = false

    
    //MARK:- UI Components
    var timerLabel: UILabel = {
        var label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: 100, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var startResetButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28)
        btn.backgroundColor = .systemGreen
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var alertLabel: UILabel = {
        let label = UILabel()
        label.text = "2 minutes is completed"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .systemIndigo
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        configureTimerLabel()
        configureButton()
        configureAlertLabel()
    }
    
    
    //MARK:- Private Helpers
    fileprivate func changeButton() {
        if isStart {
            startResetButton.setTitle("Stop", for: .normal)
            startResetButton.backgroundColor = .systemRed
        } else {
            startResetButton.setTitle("Start", for: .normal)
            startResetButton.backgroundColor = .systemGreen
        }
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0
        timerLabel.text = "00:00"
    }
    
    
    //MARK:- ObjC Helpers
    @objc func buttonTapped() {
        resetTimer(timer)
        if !isStart {
            isStart = true
            timer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            alertLabel.isHidden = true
        } else { isStart = false }
        changeButton()
    }

    @objc func updateTimer() {
        timer.counter += 1
        
        if timer.counter == 5 {
            alertLabel.isHidden = false
            AudioServicesPlaySystemSound(systemAlertSound)
            buttonTapped()
            return
        }
        
        let calcMin = "\(Int(timer.counter / 60))"
        let calcSec = "\(Int(timer.counter % 60))"
        
        var minutes = calcMin
        var seconds = calcSec
        if Int(timer.counter / 60) < 10 { minutes = "0\(calcMin)" }
        if Int(timer.counter % 60) < 10 { seconds = "0\(calcSec)" }
            
        timerLabel.text = minutes + ":" + seconds
    }

    
    //MARK:- UILayouts
    fileprivate func configureTimerLabel() {
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    fileprivate func configureButton() {
        view.addSubview(startResetButton)
        
        startResetButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        startResetButton.layer.cornerRadius = 0.5 * buttonWidth
        startResetButton.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            startResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startResetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            startResetButton.heightAnchor.constraint(equalToConstant: buttonWidth),
            startResetButton.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
    }
    
    fileprivate func configureAlertLabel() {
        view.addSubview(alertLabel)
        
        alertLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            alertLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            alertLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -30),
        ])
    }
}
