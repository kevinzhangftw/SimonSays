//
//  ViewController.swift
//  SimonSays
//
//  Created by Kevin Zhang on 2015-03-03.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redButton: SimonColorButton!
    @IBOutlet weak var greenButton: SimonColorButton!
    @IBOutlet weak var yellowButton: SimonColorButton!
    @IBOutlet weak var blueButton: SimonColorButton!
    @IBOutlet weak var whiteButton: SimonColorButton!
    
    enum SimonState {
        case Ready
        case Leading
        case Following
    }
    
    var simonState: SimonState = .Ready{
        didSet{
            switch (oldValue, simonState) {
            case (.Ready, .Leading) :
                startRound()
            case (.Leading, .Following) :
                openToUserInput()
            case (.Following, .Leading) :
                advanceToNextLevel()
            case (.Following, .Ready) :
                gameRestarts()
            default:
                assert(false, "Uh oh, we're not supposed be here!!!")
            }
        }
    }

    enum ControlColors: Int {
        case Red = 0, Blue, Green, Yellow
    }
    
    var simonSquence:[ControlColors] = []

    override func viewDidLoad() {
        redButton.setupDepression()
        blueButton.setupDepression()
        greenButton.setupDepression()
        yellowButton.setupDepression()
        whiteButton.setupDepression()
    }
    
    @IBAction func controlsTapped(sender: SimonColorButton) {
        //set alpha to all the controls
        redButton.alpha = 1
        blueButton.alpha = 1
        greenButton.alpha = 1
        yellowButton.alpha = 1
        whiteButton.alpha = 0.5
        
        //Register controls
        
        //TODO: when users done entering controls, trigger either leading or ready
        //if user enter correct controls
        //then, continus to leading
        //if user enter wrong controls
        //then continue to ready
        
    }
    func monitorControls(){
     //validate user input. get human input sequence as input and compare it with simon sequence
    }

    @IBAction func startTapped(sender: SimonColorButton) {
        simonState = .Leading
        
    }
    
    func startRound (){
        whiteButton.enabled = false
        //TODO: one button flash
        
        //set alpha to all the controls
        redButton.alpha = 0.5
        blueButton.alpha = 0.5
        greenButton.alpha = 0.5
        yellowButton.alpha = 0.5
        whiteButton.alpha = 0.5
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
            self.redButton.alpha = 1
        }) { (Bool) -> Void in
           self.simonState = .Following
        }
    }
    
    func openToUserInput (){
        redButton.enabled = true
        blueButton.enabled = true
        greenButton.enabled = true
        yellowButton.enabled = true
   
        //generate new simon sequence
        simonSquence = [.Red]
    }
    
    
    func advanceToNextLevel (){
        //TODO: flash some buttons. update the Level label, 
        
        //generate new simon sequence
        simonSquence = [.Red, .Blue, .Yellow, .Green]
    }
    
    func gameRestarts (){
        //TODO: ends the game, show that user failed.
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        super.animationDidStop(anim, finished: flag)
        //TODO: when buttons done flashing, trigger to enable color controls
    }
    
}

