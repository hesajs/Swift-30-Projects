//
//  LapTableViewCell.swift
//  Stopwatch
//
//  Created by SaJesh Shrestha on 11/4/20.
//  Copyright © 2020 SaJesh Shrestha. All rights reserved.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    let lapLabelNumber = UILabel()
    let lapLabelTimer = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lapLabelNumber)
        contentView.addSubview(lapLabelTimer)
        
        lapLabelNumber.tag = 11
        lapLabelTimer.tag = 12
        
        lapLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        lapLabelTimer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lapLabelNumber.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lapLabelNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            lapLabelNumber.widthAnchor.constraint(equalToConstant: 61),
            
            lapLabelTimer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lapLabelTimer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            lapLabelTimer.widthAnchor.constraint(equalToConstant: 115),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
