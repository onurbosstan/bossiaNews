//
//  Profile.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 7.01.2024.
//

import UIKit
import FirebaseAuth

class Profile: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProfileViewModel()
    let menuOptions: [[(title: String, image: String, bgColor: UIColor, iconColor: UIColor)]] =
       [
           [(title: "Favorite News", image: "star.fill", bgColor: UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 1.0), iconColor: .white),
            (title: "Change Password", image: "lock.fill", bgColor: UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0), iconColor: .white),
            (title: "Logout", image: "rectangle.portrait.and.arrow.right", bgColor: .red, iconColor: .white)]
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
 
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
extension Profile: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        let item = menuOptions[indexPath.section][indexPath.row]
        cell.iconBg.backgroundColor = item.bgColor
        cell.iconImageView.image = UIImage(systemName: item.image)
        cell.iconImageView.tintColor = item.iconColor
        cell.optionsLabel.text = item.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigateToChangePassword()
        case 1:
            logOut()
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func navigateToChangePassword() {
           let changePasswordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassword") as! ChangePassword
           self.navigationController?.pushViewController(changePasswordVC, animated: true)
       }
       func logOut() {
           viewModel.signOut { success in
               if success {
                   self.performSegue(withIdentifier: "toLoginScreen", sender: nil)
               } else {
                   self.makeAlert(titleInput: "Error!", messageInput: "Logout failed")
               }
           }
       }
}
