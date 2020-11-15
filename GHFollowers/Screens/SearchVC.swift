//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Aya on 10/8/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var logoImageView       = UIImageView()
    var usernameTextField   = GFTextfield()
    var callToActionBtn      = GFButton(title: "Get Followers", backgroundColor: .systemGreen)
    var isUsernameEntered : Bool{
        return !usernameTextField.text!.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,usernameTextField,callToActionBtn)
        configureLogoImageView()
        configureUsernameTextfield()
        configureCallToActionBtn()
        createDismissKeyboardTapGesture()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    @objc func pushFollowerVC() {
        guard isUsernameEntered else {
            print("empty")
            presentGFAlertOnMainThread(title: "Empty Username", message: "Pleaser enter a username. We need to know who to look for 😃.", buttonTitle: "OK")
            return
        }
        usernameTextField.resignFirstResponder()
        let followerListVC      = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
        
       }
    func createDismissKeyboardTapGesture()  {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
   
    
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Image.ghLogo
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
    
    func configureUsernameTextfield(){
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    func configureCallToActionBtn()  {
        callToActionBtn.addTarget(self, action: #selector(pushFollowerVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //pass data to next screen
        pushFollowerVC()
        return true
    }
}
