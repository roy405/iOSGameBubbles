//
//  GameViewController.swift
//  14358081_Bubblepop
//
//  Created by Cube on 4/3/23.
//

import UIKit

class GameViewController: UIViewController {

    //IBOutlet declarations for labels for time, current score, highscore and the stackview
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gameStackView: UIStackView!
    
    //Variable declaration and instantiation for height and width of game view controller stack
    var gameStackHeight = 0.0
    var gameStackWidth = 0.0
    //Getting user declared maximum number of bubbles from User defaults
    var maxBubble = Int(UserDefaults.standard.string(forKey: "bubbleSelection") ?? "15")
    //Instantiating global Bubble object
    var bubble = Bubble()
    //Array for storing the number of bubbles generated each second
    var bubbleStorage = [Bubble]()
    //Variable declaration and instantiation for previous bubble score
    var previousBubbleValue: Double = 0;
    // Variable declaration and instantiation for the current score of the player
    var currentScore: Double = 0.0
    //Variables for height and width of screen
    var screenWidth = UInt32(UIScreen.main.bounds.width)
    var screenHeight = UInt32(UIScreen.main.bounds.height)
    //Variable declaration and instantiation for playername
    var playerName: String = ""
    //Gertting the user declared max time for a single game from User defaults
    var remainingTime = Int(UserDefaults.standard.string(forKey: "timeSelection") ?? "60")
    //Instantiating a timer object
    var timer = Timer()
    //Instantiating the highscore array with hardcoded player data
    var highScore:[GameScore]=[
        GameScore(name: "Firas", Score: 92.0),
        GameScore(name: "Rama", Score: 85.0),
        GameScore(name: "Ahmed", Score: 72.0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting the max time remaining i n the time label
        timeLabel.text = UserDefaults.standard.string(forKey: "timeSelection")
        //Setting the initial score value to the score label
        scoreLabel.text = String(currentScore)
        
        //calling readfile function to read highscores from persistant file
        readFile()
        
        //Sorting the highscore array with the highest score as the first element
        highScore.sort{$0.Score > $1.Score}
        
        //Setting the highscore in the game view by taking the score value from the sorted highscore array
        highScoreLabel.text = String(highScore[0].Score)
        
        //Timer instantition with calls to couting, decideBubble and generateBubble methods
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.counting()
            self.decideBubble()
            self.generateBubble()
        }
    }
    
    //
    func counting(){
        //Everytime the remaining time value is deducted by 1 and the new valye is reflected on the time label
        remainingTime! -= 1
        timeLabel.text = String(remainingTime!)
        
        //Checking if time remaining is 0
        if remainingTime == 0 {
            //time is invalidated
            timer.invalidate()
            let finalScore = String(currentScore)
            //the final score value and player name value from segue is passed as arguments to the saveScores function
            saveScores(name: playerName, score: finalScore)
            //User Defaults is reset
            UserDefaults.resetStandardUserDefaults()
            //Automatic transition to the leaderboards page to display scores
            let leaderBoardsViewController = storyboard?.instantiateViewController(identifier: "LeaderboardsViewController") as! LeaderboardsViewController
            self.navigationController?.pushViewController(leaderBoardsViewController, animated: true)
            leaderBoardsViewController.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    //Function to generate the number of bubbles for each instance
    func generateBubble() {
        let bubbleNum = arc4random_uniform(UInt32(maxBubble! - bubbleStorage.count))
    
        var flag : Bool = false //setting a boolean flag for checking the overlapping bubbles.
        // Creating the bubble by deducting the number of bubble of the screens from the max bubble number 15 to determine how many bubbles to create.
        // The range is set to (0-15)
        if bubbleNum > 0{
            for _ in 0..<bubbleNum{
                bubble = Bubble()
                
                //Dimentions and position of the bubbble is outlined
                bubble.frame = CGRect(x: CGFloat(5 + arc4random_uniform(screenWidth - 2 * bubble.bubbleRadius - 10)), y: CGFloat(150 + arc4random_uniform(screenHeight - 2 * bubble.bubbleRadius - 170)), width: CGFloat(2 * bubble.bubbleRadius), height: CGFloat(2 * bubble.bubbleRadius))
                
                // checking if each bubble from the screen storage value overlaps with the new bubble. if it does set the flag to be true.
                for i in bubbleStorage{
                    if bubble.frame.intersects(i.frame){
                        flag = true
                    }
                }
                // create a new bubble only if the flag is set to false
                if flag == false{
                    bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
                    self.view.addSubview(bubble)
                    bubble.animation()
                    bubbleStorage.append(bubble)
                }
            }
        }
    }
    
    //Function to decide the number of bubbles to remove after each interval
    func decideBubble() {
        for index in stride(from: bubbleStorage.count-1, through: 0, by: -1) {
            bubbleStorage[index].removeFromSuperview()
            bubbleStorage.remove(at: index)
        }
    }
        
    //Method to write the highscore to a persistant file.
    func saveScores(name: String, score: String){
        let fileManager = FileManager.default
        let filePath = NSHomeDirectory() + "/score.txt"
        print(filePath)
        //If file exists then existing file is used
        if fileManager.fileExists(atPath: filePath){
            let playerData = "\n\(name)|\(score)"
            if URL(string: filePath) != nil {
                if let handle = try? FileHandle(forWritingTo: URL(string: filePath)!){
                    handle.seekToEndOfFile()
                    handle.write(playerData.data(using: .utf8)!)
                    handle.closeFile()
                }
            }
            //if file does not exist a new file is created and from next time this file is used
        } else {
            print(filePath)
            if(fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)) {
                let playerData = "\(name)|\(score)"
                if URL(string: filePath) != nil {
                    if let handle = try? FileHandle(forWritingTo: URL(string: filePath)!){
                        handle.seekToEndOfFile()
                        handle.write(playerData.data(using: .utf8)!)
                        handle.closeFile()
                    }
                }
            } else {
                print("Error in File Creaton!")
            }
        }
    }
    
    //Function to read the score file and get all playername and highscore and appending them into the highscore array
    func readFile(){
        let path = NSHomeDirectory() + "/score.txt"
        print(path)
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                for item in myStrings{
                    let a = item.split(separator: "|")
                    let scoreDict = GameScore(name: String(a[0]), Score: Double(a[1]) ?? 0)
                    highScore.append(scoreDict)
                }
            } catch {
                print(error)
        }
    }
    
    /*
    IBAction for determining scores for the bubble pressed by the user and adding them tot he currentScore variable
    If previous and current bubble scores and same, the score is multiplied by 1.5 and added to the current score
    which is ultimately displayed un the scoreLabel.
     */
    @IBAction func bubblePressed(_ sender: Bubble){
        sender.removeFromSuperview()
        if previousBubbleValue == sender.bubbleValue {
            currentScore += sender.bubbleValue * 1.5
        }
        else {
            currentScore += sender.bubbleValue
        }

        previousBubbleValue = sender.bubbleValue
        scoreLabel.text = String(currentScore)
    }
}

