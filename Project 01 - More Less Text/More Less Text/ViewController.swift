//
//  ViewController.swift
//  More Less Text
//
//  Created by SaJesh Shrestha on 10/27/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var label = UILabel()
    fileprivate var showLabel = UILabel()
    
    fileprivate var isFullHeight = false
    
    fileprivate let str = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    fileprivate var labelHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutLabelUI()
        configureLabel()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapshowLabel))
        showLabel.isUserInteractionEnabled = true
        showLabel.addGestureRecognizer(tapGesture)
    }
    
    
    func layoutLabelUI() {
        view.addSubview(label)
        view.addSubview(showLabel)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            showLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: padding),
            showLabel.centerXAnchor.constraint(equalTo: label.centerXAnchor),
        ])
        labelHeightConstraint = label.heightAnchor.constraint(equalToConstant: 100)
        labelHeightConstraint.isActive = true
    }
    
    
    func configureLabel() {
        label.text = str
        label.numberOfLines = 0
        
        showLabel.textColor = .systemBlue
        showLabel.text = "Show more"
    }
    
    
    func calculatedHeight(for text: String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    
    @objc func onTapshowLabel() {
        let fullHeight = calculatedHeight(for: str, width: label.bounds.width)
        self.labelHeightConstraint.constant = self.isFullHeight ? 45 : fullHeight
        
        UIView.animate(withDuration: 0.35) {
            self.showLabel.text = self.isFullHeight ? "Show more" : "Show less"
            self.view.layoutIfNeeded()
        }
        isFullHeight.toggle()
    }
    
}

