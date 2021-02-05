//
//  InfoSessionsTableViewController.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 29.01.2021.
//

import UIKit

class InfoSessionsTableViewController: UITableViewController {

    var exercises = [Exercise]()
    var reversedExercises = [Exercise]()
    var percentageOfDifference: Int?
    var networkManager = NetworkManager()
    
    let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonPressed))
    
    struct Cells {
        static let exerciseCell = "ExerciseCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reversedExercises = exercises
        self.title = "Exercises"
    }
    
    func configureTableView() {
        tableView.rowHeight = 100
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: Cells.exerciseCell)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return reversedExercises[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.exerciseCell) as! ExerciseTableViewCell
        let maxBpm = checkMaximumBPMForOneSession(exercises: reversedExercises)
        networkingImage(incExerciseID: reversedExercises[indexPath.section].exerciseId, cell: cell)
        cell.exerciseLabel.text = "Practices at BPM: \(reversedExercises[indexPath.section].practicedAtBpm!)"
        if reversedExercises[indexPath.section].practicedAtBpm! == maxBpm {
            if let percentage = self.percentageOfDifference {
                cell.exerciseLabel.text = "Practices at BPM: \(reversedExercises[indexPath.section].practicedAtBpm!)."
                cell.exerciseProgressLabel.text = "(\(percentage)% more than previous session!)"
            }
        }
        return cell
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reverseExercise() -> [Exercise] {
        var reversedExercise = [Exercise]()
        reversedExercise = exercises.reversed()
        return reversedExercise
    }
    
    func checkMaximumBPMForOneSession(exercises: [Exercise]) -> Int {
        var bpms: [Int] = []
        for each in exercises {
            bpms.append(each.practicedAtBpm!)
        }
        bpms.sort()
        return bpms.last!
    }
    
    func networkingImage(incExerciseID: String, cell: ExerciseTableViewCell) {
        networkManager.fetchImage(incUrl: "http://codingtest.fretello.com:3000/img/\(incExerciseID).png") { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)!
                    cell.exerciseImage.image = image
                }
            } else {
                print("Error loading image")
            }
        }
    }
}


