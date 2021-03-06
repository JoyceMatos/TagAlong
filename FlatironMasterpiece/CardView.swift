//
//  CardView.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/23/16.
//  Copyright © 2016 Elias Miller. All rights reserved.

//OK SO NEXT: add the image view constrainted to top of name field, center x axis.  Other constraints to bottom of name etc

import UIKit

class CardView: UIView {
    
    var restStore = RestaurantDataStore.sharedInstance
    var restaurant: Restaurant!
    var userStore = UsersDataStore.sharedInstance
    
    lazy var restImageView = UIImageView()
    lazy var restNameLabel = UILabel()
    lazy var restCuisineLabel = UILabel()
    lazy var restCostLabel = UILabel()
    lazy var restDistanceLabel = UILabel()
    lazy var restHoursLabel = UILabel()
    
    init(restaurant:Restaurant?, frame:CGRect){
        super.init(frame:frame)
        self.restaurant = restaurant
        
        if restaurant == nil {
            defaultSetup()
        }else{
            self.backgroundColor = UIColor.blue
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func defaultSetup(){

    }
 
    func setup() {
        // Shadow
        //  self.translatesAutoresizingMaskIntoConstraints = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
   
        let labelWidth = self.bounds.width * 0.85
        let labelXLocation = self.bounds.width * 0.08
        
        //card image view
        restImageView = UIImageView(frame: CGRect(x: self.bounds.width * -0.0001, y: self.bounds.height * -0.10, width: self.bounds.width, height: self.bounds.height * 0.66))
        restImageView.image = restaurant.photoImage
//        restImageView.contentMode = UIViewContentMode.scaleToFill
        self.addSubview(restImageView)
        restImageView.backgroundColor = UIColor.yellow

        //card restaurant name label
        restNameLabel = UILabel(frame: CGRect(x: labelXLocation, y: self.bounds.height * 0.57, width: labelWidth, height: self.bounds.width * 0.08))
        restNameLabel.textColor = phaedraOrange
        restNameLabel.font = UIFont(name: "OpenSans-Bold", size: 16.0)
        restNameLabel.text = restaurant.name
        restNameLabel.textAlignment = .center
        restHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(restNameLabel)

        //card cusisine label
        restCuisineLabel = UILabel(frame: CGRect(x: labelXLocation, y: self.bounds.height * 0.64, width: labelWidth, height: self.bounds.width * 0.08))
        restCuisineLabel.textColor = phaedraOrange
        restCuisineLabel.font = UIFont(name: "OpenSans-Semibold", size: 18.0)
        restCuisineLabel.text = userStore.currentChosenCuisine
        restCuisineLabel.textAlignment = .center
        self.addSubview(restCuisineLabel)
        
        //card restaurant pricelevel label
        restCostLabel = UILabel(frame: CGRect(x: labelXLocation, y: self.bounds.height * 0.71, width: labelWidth, height: self.bounds.width * 0.08))
        restCostLabel.textColor = phaedraOrange
        restCostLabel.font = UIFont(name: "OpenSans-semiBold", size: 18.0)
        guard let unwrappedRestCost = restStore.restaurantsArray[0].priceLevel else { return }
        let costEmoji = convertPriceToEMOJI(priceLevel: unwrappedRestCost)
        restCostLabel.text = costEmoji
        restCostLabel.textAlignment = .center
        self.addSubview(restCostLabel)
       
        //card restaurant distance label
        restDistanceLabel = UILabel(frame: CGRect(x: labelXLocation, y: self.bounds.height * 0.78, width: labelWidth, height: self.bounds.width * 0.08))
        restDistanceLabel.textColor = phaedraOrange
        restDistanceLabel.font = UIFont(name: "OpenSans-Semibold", size: 18.0)
        //TODO: - this restDistanceLabel needs to be filled with actual distance!
        restDistanceLabel.text = "0.5 mi"
        restDistanceLabel.textAlignment = .center
        self.addSubview(restDistanceLabel)

        //card restaurant hours label
        restHoursLabel = UILabel(frame: CGRect(x: labelXLocation, y: self.bounds.height * 0.85, width: labelWidth, height: self.bounds.width * 0.08))
        restHoursLabel.backgroundColor = phaedraOrange
        restHoursLabel.textColor = phaedraYellow
        restHoursLabel.font = UIFont(name: "OpenSans-Semibold", size: 12.0)
        let hoursString = convertHoursToString(isopen: restStore.restaurantsArray[0].openNow)
        restHoursLabel.text = hoursString
        restHoursLabel.textAlignment = .center
//        self.addSubview(restHoursLabel)
        
        // Corner Radius
        layer.cornerRadius = 10.0;
        
    }
    
    func convertPriceToEMOJI(priceLevel:Int)->String {
        var priceEmoji = ""
        switch priceLevel {
            case 1:
            priceEmoji = "💰"
        case 2:
            priceEmoji = "💰💰"
        case 3:
            priceEmoji = "💰💰💰"
        case 4:
            priceEmoji = "💰💰💰💰"
        default:
            break
        }
        return priceEmoji
    }
    
    func convertHoursToString(isopen:Bool)-> String {
        switch isopen {
        case false:
            return "Closed Now"
        case true:
            return "Open Now"
        }
    }

    
}
