//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Brett Mayer on 6/18/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound : AVAudioPlayer!
    
    enum Operation: String {
        case Divide
        case Multiply
        case Subract
        case Add
        case Empty
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var emptyPressed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
        runningNumber = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: Any) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: Any) {
        processOperation(operation: .Subract)
    }
    
    @IBAction func onAddPressed(sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: Any) {
        if emptyPressed {  //fixed the "= * 3" bug in beginning
            processOperation(operation: currentOperation)
            runningNumber = rightValStr  //so we can keep hitting equal to get answer
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        currentOperation = Operation.Empty
        runningNumber = "0"
        leftValStr = ""
        rightValStr = ""
        result = ""
        emptyPressed = false
        outputLbl.text = "0"
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        } else {
            btnSound.play()
        }
    }
    
    func processOperation(operation: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {

            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Subract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
                
            } //end if runn
            
        currentOperation = operation
    
    
        } else {  //first time operator has been pressed
            
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
                emptyPressed = true
    }
    
}
 

}

