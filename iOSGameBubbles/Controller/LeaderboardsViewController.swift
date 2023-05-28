//
//  LeaderboardsViewController.swift
//  14358081_Bubblepop
//
//  Created by Cube on 4/3/23.
//

import UIKit


let KEY_HIGH_SCORE = "highScore"
class LeaderboardsViewController: UIViewController {
    
    //Declaration of the IBOutlets for the tableview and a button to go back to the home back
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    //Initial hardcoded values for highscore array of type GameScore struct.
    var highScore:[GameScore]=[
        GameScore(name: "Firas", Score: 92.0),
        GameScore(name: "Rama", Score: 85.0),
        GameScore(name: "Ahmed", Score: 72.0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Calling the readFile function
        readFile()
        
        //Sorting the highscore array with the highest score as first element
        highScore.sort{$0.Score > $1.Score}
    }
    
    //Function to read the playername and score from a persistant text file
    func readFile(){
        
        //Specific path to text file
        let path = NSHomeDirectory() + "/score.txt"
            do {
                //Reading the file line by line
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                for item in myStrings{
                    let a = item.split(separator: "|") //seperating the string before and after the "|" character
                    let scoreDict = GameScore(name: String(a[0]), Score: Double(a[1]) ?? 0) //Creating new varibles of Gamescore with name and score values
                    highScore.append(scoreDict) //Appending the varibles to the highScore array
                }
            } catch {
                print(error)
        }
    }
    
    //IBAction to traverse the user back to the home/initial page
    @IBAction func toHome(_ sender: Any) {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(homeView, animated: true, completion: nil)
    }
    
}

//Protocol to customize the table with various functionalities as required
extension LeaderboardsViewController:UITableViewDelegate{
    func tableView(_ scoreTableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let index = indexPath.row
        let name = self.highScore[index]
        print("Hello\(name)")
    }
}

//Protocol to manage data sources and display data accordingly for the table
extension LeaderboardsViewController:UITableViewDataSource{
    func tableView(_ scoreTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Returns the number of elements in the highScore array
        return highScore.count
    }
    
    func tableView(_ scoreTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Uses the returned indexpath to determine the specific rows corresponding to the highScore array
        let playerScore =  highScore[indexPath.row]
        
        //Getting the cell and adding the data to the text views in the cell to create the table view
        //for playernames and scores and returning the cell
        let cell = scoreTableView.dequeueReusableCell(withIdentifier: "highScoreListItem", for: indexPath)
        cell.textLabel?.text = playerScore.name
        cell.detailTextLabel?.text = String(playerScore.Score)
        return cell
    }
}
