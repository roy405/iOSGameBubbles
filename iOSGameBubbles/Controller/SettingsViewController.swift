//
//  SettingsViewController.swift
//  14358081_Bubblepop
//
//  Created by Cube on 4/3/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var bubbleSlider: UISlider!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bubbleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializing min and max values for time slider
        //Setting initial value of time slider and time label
        timeSlider.minimumValue = 10
        timeSlider.maximumValue = 60
        timeSlider.value = 60
        timeLabel.text = String(60)
        
        //Initializing min and max values for bubble number slider
        //Setting initial value of bubble number slider and label
        bubbleSlider.minimumValue = 5
        bubbleSlider.maximumValue = 15
        bubbleSlider.value = 15
        bubbleLabel.text = String(15)
    }
    /*
    IBAction for time slider change where the value is taken from the slider upon change and
    updated on the time label to display to the user.
     
    The value is also set to the User Defaults and is used as the selected settings for the game to be played
    by the user.
     */
    @IBAction func timeSliderChange(_ sender: UISlider) {
        let roundedTimeValue = round(sender.value)
        sender.value = roundedTimeValue
        timeLabel.text = Int(sender.value).description
        UserDefaults.standard.set(Int(sender.value).description, forKey: "timeSelection")
    }
    
    
    /*
    IBAction for bubble number slider change where the value is taken from the slider upon change and
    updated on the bubble label to display to the user.
     
    The value is also set to the User Defaults and is used as the selected settings for the game to be played
    by the user.
     */
    @IBAction func bubbleSliderChange(_ sender: UISlider) {
        let roundedBubbleValue = round(sender.value)
        sender.value = roundedBubbleValue
        bubbleLabel.text = Int(sender.value).description
        UserDefaults.standard.set(Int(sender.value).description, forKey: "bubbleSelection")
    }
    

}
