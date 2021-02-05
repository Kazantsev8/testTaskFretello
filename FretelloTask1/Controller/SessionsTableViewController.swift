//
//  SessionsTableViewController.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 28.01.2021.
//

import UIKit

class SessionsTableViewController: UITableViewController {
    
    struct Cells {
        static let sessionCell = "SessionCell"
    }
    
    var sessions = [Session]()
    var exerciseImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = false
        self.tableView.reloadData()
        self.title = "Fretello Session's"
        let maxIncrease = findingMaximumIncrease()
        NSLog("Maximum increase - \(maxIncrease)%")
    }
    
    func configureTableView() {
        tableView.rowHeight = 100
        tableView.register(SessionTableViewCell.self, forCellReuseIdentifier: Cells.sessionCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.sessionCell) as! SessionTableViewCell
            cell.mainLabel.text = self.sessions[indexPath.row].name!
            let date = convertDateFormatter(inputDate: self.sessions[indexPath.row].practicedOnDate!)
            cell.dateLabel.text = date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoSessionsTableViewController = InfoSessionsTableViewController()
        infoSessionsTableViewController.exercises = self.sessions[indexPath.row].exercises!
        if indexPath.row >= 1 {
            let averageBPMForPreviousSession = checkAverageBPMForOneSession(exercises: self.sessions[indexPath.row-1].exercises!)
            let maxBPMForCurrentSession = checkMaximumBPMForOneSession(exercises: self.sessions[indexPath.row].exercises!)
            let differenceOfBPMs = calculateDifferenceOfBPMs(currentMax: Double(maxBPMForCurrentSession), previousAvg: averageBPMForPreviousSession)
            infoSessionsTableViewController.percentageOfDifference = differenceOfBPMs
        }
        self.navigationController?.pushViewController(infoSessionsTableViewController, animated: true)
    }
    
    func convertDateFormatter(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: inputDate)
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
        return dateFormatter.string(from: date!)
    }
    
    func checkAverageBPMForOneSession(exercises: [Exercise]) -> Double {
        var averageBPM: Double = 0
        for each in exercises {
            averageBPM = averageBPM + Double(each.practicedAtBpm!)
        }
        averageBPM = (averageBPM/Double(exercises.count))
        return averageBPM
    }
    
    func checkMaximumBPMForOneSession(exercises: [Exercise]) -> Int {
        var bpms: [Int] = []
        for each in exercises {
            bpms.append(each.practicedAtBpm!)
        }
        bpms.sort()
        return bpms.last!
    }
    
    func checkMaximumBPMsForAllSessions(sessions: [Session]) -> [Int] {
        var maximumBPMsArray: [Int] = []
        for each in sessions {
            let maxBPM = checkMaximumBPMForOneSession(exercises: each.exercises!)
            maximumBPMsArray.append(maxBPM)
        }
        return maximumBPMsArray
    }
    
    func calculateDifferenceOfBPMs(currentMax: Double, previousAvg: Double) -> Int {
        let percent = Int((currentMax/previousAvg)*100)-100
        return percent
    }
    
    func findingMaximumIncrease() -> Int {
        var averageBPMArray: [Double] = []
        let maximumBPMsArray = checkMaximumBPMsForAllSessions(sessions: sessions)
        var maximumIncreaseArray: [Double] = []
        for each in sessions {
            let averageBPM = checkAverageBPMForOneSession(exercises: each.exercises!)
            averageBPMArray.append(averageBPM)
        }
        for (index1, _) in maximumBPMsArray.enumerated() {
            for (index2, _) in averageBPMArray.enumerated() {
                if index1 == index2, index2 > 0 {
                    maximumIncreaseArray.append(Double(maximumBPMsArray[index2])/averageBPMArray[index2-1]*100)
                }
            }
        }
        maximumIncreaseArray.sort()
        print(maximumIncreaseArray)
        return Int(maximumIncreaseArray.last!)
    }
    
}


