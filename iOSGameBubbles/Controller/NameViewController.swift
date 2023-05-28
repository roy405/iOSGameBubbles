//
//  NameViewController.swift
//  14358081_Bubblepop
//
//  Created by Cube on 4/3/23.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Passing value of name entered in field through segue from the NameViewController to the GameViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController else {return}
        let playername = usernameTextField.text
        if playername == ""{
            gameViewController.playerName = "player"
        }
        else{
            gameViewController.playerName = usernameTextField.text ?? "player"
        }
        
    }

    @IBAction func startGame(_ sender: Any) {
        
    }
}
