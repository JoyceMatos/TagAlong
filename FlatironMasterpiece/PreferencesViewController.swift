//
//  PracticeViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import FirebaseAuth

class PreferenceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
     let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
     let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
     let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
     let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)
    
    let store = UsersDataStore.sharedInstance
    var usersCuisineSelectionsArray:[String] = []
    
    var preferencesLabel = UILabel()
    var budgetLabel = UILabel()
    var dineWithCompanyLabel = UILabel()
    var dineWithCompanySwitch = UISwitch()
    var replayTutorialButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))
    var logoutButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 35))
    var cuisinePreferencesLabel = UILabel()
    var cuisineCollectionView:UICollectionView!
    let cuisineReuseIdentifier = "Cuisine Cell"
    
    let cuisineImage:[UIImage] = [UIImage(named: "american")!, UIImage(named:"asian")!, UIImage(named: "Healthy")!, UIImage(named: "Italian")!, UIImage(named: "Latin3x")!, UIImage(named: "Unhealthy2x")!]
    
    let cuisineArray:[String] = ["american", "asian", "healthy", "italian", "latin", "unhealthy"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preferences View"

        view.backgroundColor = phaedraYellow
        createSegmentedController()
        formatPreferenceLabel()
        formatBudgetLabel()
        formatButtons()
        layoutCuisineCollectionView()
        formatCuisinePreferencesLabel()
    }
    
    func layoutCuisineCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        cuisineCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        cuisineCollectionView.backgroundColor = phaedraDarkGreen
        view.addSubview(cuisineCollectionView)

        print("cuisineCollectionView frame assigned")
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 145).isActive = true
        cuisineCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisineCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        cuisineCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineReuseIdentifier, for: indexPath) as! CuisineCollectionViewCell
        
        cell.imageView.image = cuisineImage[indexPath.item]
        cell.foodLabel.text = cuisineArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCuisine = cuisineArray[indexPath.row]
        var selectedCuisineIsHighlighted:Bool = false
        
        print("array before selections is \(usersCuisineSelectionsArray)")
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if !(cell?.isHighlighted)! {
            
            usersCuisineSelectionsArray.append(selectedCuisine)
            selectedCuisineIsHighlighted = true
            cell?.layer.borderWidth = 8
            cell?.layer.borderColor = self.phaedraLightGreen.cgColor
            cell?.layer.cornerRadius = 5
            print("array after a selection made: \(usersCuisineSelectionsArray)")
            
        } else if (cell?.isHighlighted)! {
            
            cell?.layer.borderWidth = 0
            usersCuisineSelectionsArray.remove(at: usersCuisineSelectionsArray.count-1)
            print("array after a deselection is made: \(usersCuisineSelectionsArray)")
            selectedCuisineIsHighlighted = false
        }

    }
    
//    func formatSwitch() {
//        view.addSubview(dineWithCompanySwitch)
//        dineWithCompanySwitch.center = view.center
//        dineWithCompanySwitch.setOn(false, animated: false)
//        dineWithCompanySwitch.tintColor = phaedraDarkGreen
//        dineWithCompanySwitch.onTintColor = phaedraDarkGreen
//        dineWithCompanySwitch.thumbTintColor = phaedraLightGreen
//        dineWithCompanySwitch.addTarget(self, action: #selector(findDiningPartner), for: UIControlEvents.valueChanged)
//        dineWithCompanySwitch.translatesAutoresizingMaskIntoConstraints = false
//        dineWithCompanySwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        dineWithCompanySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 95).isActive = true
//        dineWithCompanySwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
//    }
    
    func formatPreferenceLabel() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        // TODO: - decide on preferences label font and font size
        preferencesLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        preferencesLabel.textColor = phaedraOrange
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
    }
    
    func formatBudgetLabel() {
        view.addSubview(budgetLabel)
        budgetLabel.text = "Choose your budget"
        budgetLabel.font = UIFont(name: "OpenSans-Light", size: 20.0)
        budgetLabel.textColor = phaedraOrange
        budgetLabel.textAlignment = .center
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -170).isActive = true
        budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //add special constraint functionality
//        budgetLabel.specialConstrain(to: view)

    }
    
    func formatCuisinePreferencesLabel() {
        view.addSubview(cuisinePreferencesLabel)
        cuisinePreferencesLabel.text = "Select your cuisine preferences"
        cuisinePreferencesLabel.font = UIFont(name: "OpenSans-Light", size: 20.0)
        cuisinePreferencesLabel.textColor = phaedraOrange
        cuisinePreferencesLabel.textAlignment = .center
        cuisinePreferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        cuisinePreferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisinePreferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 35).isActive = true
    }
    
//    func formatDineWithCompanyLabel() {
//        view.addSubview(dineWithCompanyLabel)
//        dineWithCompanyLabel.text = "Dine with company?"
//        dineWithCompanyLabel.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
//        dineWithCompanyLabel.textColor = phaedraOrange
//        dineWithCompanyLabel.textAlignment = .center
//        dineWithCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
//        dineWithCompanyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
//        dineWithCompanyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
//    }
    
    func createSegmentedController() {
        let budgetArray:[String] = ["💰", "💰💰", "💰💰💰", "💰💰💰💰"]
        let budgetSC = UISegmentedControl(items: budgetArray)
        budgetSC.selectedSegmentIndex = 0
        
        let frame = UIScreen.main.bounds
        budgetSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 140, width: frame.width - 20, height: frame.height * 0.08)
        
        budgetSC.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir Next", size: 16.0)! ], for: .normal)
        budgetSC.layer.cornerRadius = 5
        budgetSC.backgroundColor = phaedraLightGreen
        budgetSC.tintColor = phaedraDarkGreen
        budgetSC.addTarget(self, action: #selector(printChosenBudget(sender:)), for: .valueChanged)
        
        self.view.addSubview(budgetSC)
        
    }
    
    func printChosenBudget(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(1, forKey: "Budget")
            print("user chose 💰")
        case 1:
            UserDefaults.standard.set(2, forKey: "Budget")
            print("user chose 💰💰")
        case 2:
            UserDefaults.standard.set(3, forKey: "Budget")
            print("user chose 💰💰💰")
        case 3:
            UserDefaults.standard.set(4, forKey: "Budget")
            print("user chose 💰💰💰💰")
        default:
            print("user chose 💰💰")
        }
    }
    
    func formatButtons() {
        
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = phaedraLightGreen
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 20.0)
        
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        logoutButton.setTitleColor(phaedraDarkGreen, for: .normal)
        logoutButton.setTitleColor(phaedraYellow, for: .highlighted)
        
        view.addSubview(replayTutorialButton)
        // TODO: - change button color
        replayTutorialButton.backgroundColor = phaedraLightGreen
        replayTutorialButton.layer.cornerRadius = 5
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 20.0)
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -65).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(replayTutorial), for: .touchUpInside)
        replayTutorialButton.setTitleColor(phaedraDarkGreen, for: .normal)
        replayTutorialButton.setTitleColor(phaedraYellow, for: .highlighted)
        
    }
    
    // MARK: - selector functions for buttons
    
    // TODO: - write function that finds a dining partner
    func findDiningPartner(sender: UISwitch!) {
        if !sender.isOn {print("User wants to dine alone.")} else {
            print("User wants to dine with a partner!")
        }
    }
    
    // TODO: - write function that displays replayTutorial
    func replayTutorial() {
        print("Replay tutorial requested.")
    }
    
    // TODO: - write function that logs user out of the app
    func logoutUser() {
        print("User tapped button to logout.")
        // Send to loginview
        //TODO: - 
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("successfully logged out of firebase")
        } catch {
            print("Logout of app error")
        }
        
        let loginVC = LogInViewController()
        
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}


















