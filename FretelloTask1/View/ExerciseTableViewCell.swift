//
//  ExerciseTableViewCell.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 03.02.2021.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    var exerciseImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
    var exerciseLabel = UILabel()
    var exerciseProgressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(exerciseImage)
        addSubview(exerciseLabel)
        addSubview(exerciseProgressLabel)
        setExerciseLabelConstraints()
        setExerciseProgressLabelConstraints()
        setExerciseImageConstraints()
        configureExerciseLabel()
        configureExerciseProgressLabel()
        configureExerciseImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(exerciseImage)
        addSubview(exerciseLabel)
        addSubview(exerciseProgressLabel)
    }
    
    func configureExerciseImage() {
        exerciseImage.layer.cornerRadius = 40
    }
    
    func configureExerciseLabel() {
        exerciseLabel.numberOfLines = 0
        exerciseLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureExerciseProgressLabel() {
        exerciseProgressLabel.numberOfLines = 0
        exerciseProgressLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setExerciseLabelConstraints() {
        exerciseLabel.translatesAutoresizingMaskIntoConstraints                                                         = false
        exerciseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive                                   = true
        exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 10).isActive            = true
        exerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                        = true
        exerciseLabel.heightAnchor.constraint(equalToConstant: 40).isActive                                             = true
    }
    
    func setExerciseProgressLabelConstraints() {
        exerciseProgressLabel.translatesAutoresizingMaskIntoConstraints                                                 = false
        exerciseProgressLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 10).isActive    = true
        exerciseProgressLabel.heightAnchor.constraint(equalToConstant: 20).isActive                                     = true
        exerciseProgressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                = true
        exerciseProgressLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 10).isActive          = true
    }
    
    func setExerciseImageConstraints() {
        exerciseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive                           = true
        exerciseImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive                                   = true
        exerciseImage.heightAnchor.constraint(equalToConstant: 80).isActive                                             = true
        exerciseImage.widthAnchor.constraint(equalToConstant: 80).isActive                                              = true
    }
    
    
}
