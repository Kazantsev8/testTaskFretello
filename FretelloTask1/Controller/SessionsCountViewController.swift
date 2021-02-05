//
//  SessionsCountViewController.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 28.01.2021.
//

import UIKit

class SessionsCountViewController: UIViewController {

    var networkManager = NetworkManager()
    var sessions = [Session]()
    var exerciseIDs = [String]()
    var exerciseImages = [UIImage]()
    
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.text = "http://codingtest.fretello.com:3000/data/sessions.json"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sessionsCountCheckButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.setTitle("check", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSessionsTableViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    func urlTextFieldConstraints() {
        urlTextField.translatesAutoresizingMaskIntoConstraints                                                      = false
        urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive                   = true
        urlTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive                           = true
        urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive                = true
        urlTextField.heightAnchor.constraint(equalToConstant: 50).isActive                                          = true
    }
 
    func sessionsCountCheckButtonConstraints() {
        sessionsCountCheckButton.translatesAutoresizingMaskIntoConstraints                                          = false
        sessionsCountCheckButton.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 30).isActive    = true
        sessionsCountCheckButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                = true
        sessionsCountCheckButton.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
        sessionsCountCheckButton.widthAnchor.constraint(equalToConstant: 150).isActive                              = true
    }
    
    @IBAction func presentSessionsTableViewController (_ sender: UIButton) {
        
        let sessionsTableViewController = SessionsTableViewController()
        sessionsTableViewController.sessions = sessions
        sessionsTableViewController.exerciseImages = exerciseImages
        
        let navigationController = UINavigationController(rootViewController: sessionsTableViewController)
        navigationController.viewControllers = [sessionsTableViewController]
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18)!]
        navigationController.navigationBar.titleTextAttributes = attributes
        self.present(navigationController, animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.sessionsCountCheckButton.transform = .init(scaleX: 0.9, y: 0.9)
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.sessionsCountCheckButton.transform = .init(scaleX: 1, y: 1)
        })
    }
    
    func networkingSessions() {
        if let text = urlTextField.text {
            networkManager.fetchSessions(incUrl: text) { sessions in
                guard let localSessions = sessions else {
                    return
                }
                DispatchQueue.main.async { [self] in
                    self.sessions = localSessions
                }
            }
        } else { return }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkingSessions()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.addSubview(urlTextField)
        view.addSubview(sessionsCountCheckButton)
        urlTextFieldConstraints()
        sessionsCountCheckButtonConstraints()
        urlTextField.isUserInteractionEnabled = false
    }

}


