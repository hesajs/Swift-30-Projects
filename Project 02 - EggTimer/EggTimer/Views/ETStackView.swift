//
//  ETStackView.swift
//  EggTimer
//
//  Created by SaJesh Shrestha on 10/28/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

class ETStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.spacing = spacing
        configureStackView()
    }
    
    func configureStackView() {
        alignment = .fill
        distribution = .fillEqually
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
