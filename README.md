# iOSGameBubbles:
 An iOS based game developed using swift and storyboard. A simple game where the user is provided with a number of bubbles on the screen where the user taps to get the score. A timer starts as the game begins as the system starts generating a random number of bubbles each second on the screen in different positions. Each bubble is assigned a different score and upon popping the bubble, the user adds that corresponding score to their total score. The objective is to pop as many bubbles as possible before the time runs out. Upon the timer turning to 0, the user's score is added to a list of scores where it's sorted according to the existing scores and ish displayed with the highest score on topp along with the name of the player. 
 
 # Functionalities and Views:
 
 ## Main System Flow:
 - The home page consists of the **logo** of the game, the **play** button in the center, the **settigns** and the leaderboards **buttons**.
 - Upon pressing the **play** button, the user is taken to another screen where the system prompts the user to enter their name.
 - The user can enter their name and press **start**. (If the field is left empty, it automatically assigns a default name 'player' to the user)
 - Upon pressing the **start** button, the user is shown with the game screen, where the timer, highscore and the players scores are shown, bubbles appear on the screen where the user upon tapping gets the respective colors' score added to their overall score. 
 - As the timer expires, the user is taken to the leaderboards screen where the user is presented with how they did compared to other players.
 - Upon pressing the 'home' button, the user is taken to the home screen where the user can start another game again.

 ## Settings Screen:
 - Upon clicking on the **settings* button, the user is taken to another screen where the user can change the settings for 
    - The max number of bubbles to generate (max 15, min 1)
    - The max seconds for the time (max 60 seconds)
 - Upon clicking done, the settings are saved for the user.

 ## Leaderboards Screen:
 - Upon clicking on the leaderboards screen, the user can see the list of all scores and corresponding players in a *highest score first* precedence.

# How to Run:

- The system can be run by running the application on Xcode. 
- The app has not yet been published in the Appstore,  hence the only way to run it is through loading it on a physical device through a Mac and Xcode.
