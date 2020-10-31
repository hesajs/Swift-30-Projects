//
//  ETImageView.swift
//  EggTimer
//
//  Created by SaJesh Shrestha on 10/28/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

class ETImageView: UIImageView {
    
    var imageName: String!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureImageview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String) {
        super.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.imageName = imageName
        configureImageview()
    }
    
    func configureImageview() {
        contentMode = .scaleAspectFit
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
