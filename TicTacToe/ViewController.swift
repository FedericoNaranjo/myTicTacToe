//
//  ViewController.swift
//  TicTacToe
//
//  Created by Federico Naranjo Bellina on 22/6/16.
//  Copyright © 2016 Rico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resetConstraintCenter: NSLayoutConstraint!
    @IBOutlet var resetConstraintY: NSLayoutConstraint!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    var currentUser = 1
    let xUser = 1
    let oUser = 2
    
    var winner = false
    var draw = false
    
    var currentGameState = [0,0,0, 0,0,0, 0,0,0]
    
    let winStates = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ]
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        // if button has not been pressed & no winner found
        if currentGameState[sender.tag - 1] == 0 && !winner {
            
            currentGameState[sender.tag - 1] = currentUser
            
            if currentUser == xUser {
                currentUser = oUser
                sender.setBackgroundImage(UIImage(named:"xSymbol.png"), forState: .Normal)
            }
            else {
                currentUser = xUser
                sender.setBackgroundImage(UIImage(named:"oSymbol.png"), forState: .Normal)
            }
            
            // Check for winning combination
            
            for combination in winStates {
                
                // if the first one isn't undefined & first = second & second = third
                if currentGameState[ combination[0]-1 ] != 0 && currentGameState[ combination[0]-1 ] == currentGameState[ combination[1]-1 ] && currentGameState[ combination[1]-1 ] == currentGameState[ combination[2]-1 ] {
                    
                    // **** WINNER FOUND ****
                    
                    // remember currentUser was already changed to next user
                    if currentGameState[ combination[0]-1 ] == oUser {
                        winnerLabel.text = "Player O Wins!"
                    }
                    else {
                        winnerLabel.text = "Player X Wins!"
                    }
                    winnerLabel.hidden = false
                    
                    winner = true
                    playAgainButton.hidden = false
                    
                }
                
            } // end check for winner
            
            
            // check for draw
            if !winner {
                draw = true
                for thing in currentGameState {
                    if thing == 0 {
                        draw = false
                    }
                }
                if draw {
                    winnerLabel.text = "Draw!"
                    winnerLabel.hidden = false
                    playAgainButton.hidden = false

                }
            } // end draw check
            
            
            // end game animations
            if winner || draw {
                
                // different animations each time
                let random = Int(arc4random_uniform(5))

                switch random {
                case 0:
                    UIView.animateWithDuration(0.65, animations: {
                        self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x+400, self.winnerLabel.center.y)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x-400, self.playAgainButton.center.y)
                        
                        // move a button
                        self.resetConstraintCenter.constant = -400.0
                        self.resetButton.center = CGPointMake(self.resetButton.center.x-400, self.resetButton.center.y)
                    })
                   
                case 1:
                    UIView.animateWithDuration(0.65, animations: {
                        self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x-400, self.winnerLabel.center.y)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x+400, self.playAgainButton.center.y)
                        
                        // move a button
                        self.resetConstraintCenter.constant = 400.0
                        self.resetButton.center = CGPointMake(self.resetButton.center.x+400, self.resetButton.center.y)
                    })
                    
                case 2:
                    UIView.animateWithDuration(0.65, animations: {
                        self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x-400, self.winnerLabel.center.y-400)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x+400, self.playAgainButton.center.y+400)
                        
                        // move a button
                        self.resetConstraintCenter.constant = 400.0
                        self.resetButton.center = CGPointMake(self.resetButton.center.x+400, self.resetButton.center.y+400)
                    })
                    
                case 3:
                    UIView.animateWithDuration(0.65, animations: {
                        self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x+400, self.winnerLabel.center.y+400)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x-400, self.playAgainButton.center.y-400)
                        
                        // move a button
                        self.resetConstraintCenter.constant = -400.0
                        self.resetConstraintY.constant -= 400
                        self.resetButton.center = CGPointMake(self.resetButton.center.x-400, self.resetButton.center.y-400)
                    })
                    
                case 4:
                    UIView.animateWithDuration(0.65, animations: {
                        self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x, self.winnerLabel.center.y+600)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x, self.playAgainButton.center.y-400)
                        
                        // move a button
                        self.resetConstraintY.constant -= 200
                        self.resetButton.center = CGPointMake(self.resetButton.center.x, self.resetButton.center.y-200)
                    })
                
                default:
                    print("error")
                }
                
            }
        } // end
        
    }
    
    @IBAction func reset() {
        
        if winner || draw { // reset from end game animations
            self.resetConstraintCenter.constant = 0.0 // centred
            self.resetConstraintY.constant = 18 // default position in storyboard
        }
        
        let random = Int(arc4random_uniform(2))
        
        currentUser = random + 1
        winner = false
        draw = false
        playAgainButton.hidden = true
        winnerLabel.hidden = true

        currentGameState = [0,0,0, 0,0,0, 0,0,0]
        
        // clear each button
        if !winner  {
            var buttonToClear:UIButton
            
            for i in 1...9 {
                buttonToClear = view.viewWithTag(i) as! UIButton
                buttonToClear.setBackgroundImage(nil, forState: .Normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

