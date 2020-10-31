//
//  ETLabel.swift
//  EggTimer
//
//  Created by SaJesh Shrestha on 10/28/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

class ETLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, font: UIFont, textColor: UIColor) {
        super.init(frame: .zero)
        
        self.text = text
        self.font = font
        self.textColor = textColor
        configureLabel()
    }
    
    func configureLabel() {
//        textColor = .secondaryLabel
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
