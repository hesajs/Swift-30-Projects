//
//  ViewController.swift
//  EggTimer
//
//  Created by SaJesh Shrestha on 10/28/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK:- Properties
    
    let verticalStackView = ETStackView(axis: .vertical, spacing: 39)
    let eggStackView = ETStackView(axis: .horizontal, spacing: 20)
    let titleLabel = ETLabel(text: "How do you like your eggs?", font: .systemFont(ofSize: 30, weight: .medium), textColor: .secondaryLabel)
    let softEggLabel = ETLabel(text: Hardness.soft, font: .systemFont(ofSize: 18, weight: .heavy), textColor: .systemGray6)
    let mediumEggLabel = ETLabel(text: Hardness.medium, font: .systemFont(ofSize: 18, weight: .heavy), textColor: .white)
    let hardEggLabel = ETLabel(text: Hardness.hard, font: .systemFont(ofSize: 18, weight: .heavy), textColor: .white)
    let softEggImageView = ETImageView(imageName: EggImage.soft)
    let mediumEggImageView = ETImageView(imageName: EggImage.medium)
    let hardEggImageView = ETImageView(imageName: EggImage.hard)
    
    let timerView = UIView()
    let eggTime = [0: 3*60, 1: 4, 2: 7*60]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    let progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.progress = 0.5
        pv.progressTintColor = .systemYellow
        pv.trackTintColor = .systemGray
        pv.backgroundColor = .blue
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        configureVerticalStack()
        configureEggStackView()
        configureEggImageView()
    }
    
    
    //MARK:- Configurations
    
    func configureVerticalStack() {
        view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(eggStackView)
        verticalStackView.addArrangedSubview(timerView)
        
        timerView.addSubview(progressView)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 5),
        ])
    }
    
    
    func configureEggStackView() {
        eggStackView.addArrangedSubview(softEggImageView)
        eggStackView.addArrangedSubview(mediumEggImageView)
        eggStackView.addArrangedSubview(hardEggImageView)
        
        softEggImageView.addSubview(softEggLabel)
        mediumEggImageView.addSubview(mediumEggLabel)
        hardEggImageView.addSubview(hardEggLabel)
        
        softEggLabel.isUserInteractionEnabled = false
        mediumEggLabel.isUserInteractionEnabled = false
        hardEggLabel.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            softEggLabel.centerYAnchor.constraint(equalTo: softEggImageView.centerYAnchor),
            softEggLabel.centerXAnchor.constraint(equalTo: softEggImageView.centerXAnchor),
            
            mediumEggLabel.centerYAnchor.constraint(equalTo: mediumEggImageView.centerYAnchor),
            mediumEggLabel.centerXAnchor.constraint(equalTo: mediumEggImageView.centerXAnchor),
            
            hardEggLabel.centerYAnchor.constraint(equalTo: hardEggImageView.centerYAnchor),
            hardEggLabel.centerXAnchor.constraint(equalTo: hardEggImageView.centerXAnchor),
        ])
        
    }
    
    
    func configureEggImageView() {
        softEggImageView.tag = 0
        mediumEggImageView.tag = 1
        hardEggImageView.tag = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        softEggImageView.addGestureRecognizer(tapGesture)

        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        mediumEggImageView.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        hardEggImageView.addGestureRecognizer(tapGesture2)
    }
    
    
    //MARK:- Gesture Configuration
    
    @objc func imageTapped(gesture: UITapGestureRecognizer) {
        timer.invalidate()
        
        let hardness = gesture.view!.tag
        totalTime = eggTime[hardness]!
        progressView.progress = 0
        secondsPassed = 0
        titleLabel.text = hardness == 0 ? Hardness.soft : hardness == 1 ? Hardness.medium : Hardness.hard
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if(secondsPassed < totalTime) {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
    }
    
    
    func playSound() {
        do {
            let audioPath = Bundle.main.url(forResource: "tone", withExtension: "mp3")
            player = try AVAudioPlayer(contentsOf: audioPath!)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

