//
//  UserViewController.swift
//  NewsToDay
//
//  Created by vp.off on 22.10.2024.
//

import UIKit

class UserViewController: UITableViewController {
    
    private var rows: [[String]] = [
        ["Dev P, dev@gmail.com"],     // Секция 0 -  User Information
        ["Language"],                  // Секция 1 - Primary Settings
        ["Terms & Conditions"],        // Секция 2 - Secondary Settings
        ["Sign Out"]                   // Секция 3 - Logout
    ]
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    //MARK: - Private Methods
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 96, right: 0)
        
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: "UserInfoCell")
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.register(LogoutCell.self, forCellReuseIdentifier: "LogoutCell")
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
  
}

// MARK: - UITableViewDataSource
extension UserViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rows.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.section][indexPath.row]

        switch row {
        case "Dev P, dev@gmail.com":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell else {
                return UITableViewCell()
            }
            cell.configure(name: "Dev P", email: "dev@gmail.com")
            return cell

        case "Language":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
                return UITableViewCell()
            }
            cell.configure(title: "Language", showDisclosure: true)
            return cell

        case "Terms & Conditions":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
                return UITableViewCell()
            }
            cell.configure(title: "Terms & Conditions", showDisclosure: true)
            return cell

        case "Sign Out":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as? LogoutCell else {
                return UITableViewCell()
            }
            cell.configure(title: "Sign Out")
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let row = rows[indexPath.section][indexPath.row]
//        if row == "Language" {
//            let languageVC = LanguageViewController()
//            languageVC.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(languageVC, animated: true)
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.section][indexPath.row]
        
        switch row {
        case "Language":
            let languageVC = LanguageViewController()
            languageVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(languageVC, animated: true)
            
        case "Terms & Conditions":
            let termsVC = TermsConditionsViewController()
            termsVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(termsVC, animated: true)
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 15
        case 2:
            return 250
        case 3:
            return 0
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
