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
  
  @IBOutlet weak var gameLevel: UILabel!
  @IBOutlet weak var gameOver: UILabel!
  
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
      case (.Following, .Following) :
        openToUserInput()
      case (.Following, .Leading) :
        advanceToNextLevel()
      case (.Following, .Ready) :
        gameRestarts()
      case (.Ready, .Following) :
        println("debugging state change!!!")
      default:
        assert(false, "Uh oh, we're not supposed be here!!!")
      }
    }
  }
  
  
  
  override func viewDidLoad() {
    realStart()
//    mockStart()
    
  }
  
  var buttonArray: [SimonColorButton] = []
  func realStart() {
    self.addButtonsToTheButtonArray()
  }
  
  func mockStart() {
    //simonState = .Leading
    showSequence.append(self.blueButton)
    showSequence.append(self.redButton)
    showSequence.append(self.yellowButton)
    showSequence.append(self.greenButton)
    animateUntilEndOfShowSequence()
  }
  
  var senderArray: [SimonColorButton] = []
  @IBAction func controlsTapped(sender: SimonColorButton) {
    
    senderArray.append(sender)

    if senderArray.count == showSequence.count{
      controlsTappedEvaluation()
      senderArray = []
    }
    
  }
  
  func controlsTappedEvaluation(){
    if senderArray == showSequence {
      advanceToNextLevel()
    } else {
        gameRestarts()
    }
  }

  
  @IBAction func startTapped(sender: SimonColorButton) {
    simonState = .Leading
  }
  
  var showSequence: [SimonColorButton] = []
  func startRound (){
    showSequence.append(buttonArray[Int(arc4random_uniform(UInt32(3 - 0 + 1)))])
//    closeUserInput()
    UIView.animateWithDuration(1, delay: 0, options: .Autoreverse, animations: { () -> Void in
      self.showSequence[0].alpha = 0
      }) { (Bool) -> Void in
        self.showSequence[0].alpha = 1
        self.simonState = .Following
    }
  }
  
  func openToUserInput (){
    redButton.enabled = true
    greenButton.enabled = true
    yellowButton.enabled = true
    blueButton.enabled = true
  }
  
  func closeUserInput (){
    redButton.enabled = false
    greenButton.enabled = false
    yellowButton.enabled = false
    blueButton.enabled = false

  }
  
  func advanceToNextLevel (){
    println("level advanced")
//    closeUserInput()
    showSequence.append(buttonArray[Int(arc4random_uniform(UInt32(3 - 0 + 1)))])
    self.animateUntilEndOfShowSequence()
    animationCounter = 0
  }
  
  var animationCounter: Int = 0
  func animateUntilEndOfShowSequence() {
    let animatingButton = showSequence[self.animationCounter]
    UIView.animateWithDuration( 1, delay: 0, options: .Autoreverse,
      animations: { () -> Void in
        animatingButton.alpha = 0
      }) { (Bool) -> Void in
        animatingButton.alpha = 1
        self.animationCounter++
        self.animateNextIfNotLast()
    }
    
  }

  func animateNextIfNotLast() {
    if self.animationCounter == self.showSequence.count{ //end of showSequence
      self.simonState = .Following
    } else {
      self.animateUntilEndOfShowSequence()
    }
  }
  
  func gameRestarts (){
    println("game over")
    gameOver.text = "GAME OVER"
  }
  
  func addButtonsToTheButtonArray (){
    buttonArray = [redButton, greenButton, yellowButton, blueButton]
  }
}