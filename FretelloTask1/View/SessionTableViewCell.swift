//
//  SessionTableViewCell.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 30.01.2021.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    var mainLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainLabel)
        addSubview(dateLabel)
        configureMainLabel()
        configureDateLabel()
        setMainLabelConstraints()
        setDateLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(mainLabel)
        addSubview(dateLabel)
    }
    
    func configureMainLabel() {
        mainLabel.numberOfLines = 0
        mainLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 0
        dateLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setMainLabelConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive                   = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive           = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive        = true
        mainLabel.heightAnchor.constraint(equalToConstant: 40).isActive                             = true
    }
    
    func setDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints                                         = false
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive           = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive                             = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive        = true
        dateLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10).isActive      = true
    }
    
}
