//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Spencer Lidstrom on 2/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    // flags
    var clearDisplay = false
    var isValidPress = false
    
    // creating a reference of our logic manager class
    var logicManager = LogicManager()
    
    // Storyboard elements
    @IBOutlet weak var total: UILabel!
    
    // View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Storyboard Actions
    @IBAction func numberTapped(_ sender: UIButton) {
        
        // Number was clicked, enable operations to be clicked as well
        isValidPress = true
        
        // if this is an already calculated value, reset the calculator to allow fresh entry
        if logicManager.calculationArray.count == 1 {
            total.text = ""
            logicManager.calculationArray.removeAll()
            logicManager.currentNumber = 0.0
            logicManager.lastOperation = 0.0
            logicManager.lastNumber = 0.0
            clearDisplay = false
            isValidPress = false
        }
        
        // tells the view whether we should clear the view or not
        if clearDisplay == true {
            total.text = ""
            clearDisplay = false
        }
        
        // add a number to the total label
        total.text! += sender.titleLabel!.text!
        
        // update the current number displayed in the total label
        logicManager.currentNumber = Double(total.text!)!
    }
    
    
    @IBAction func operationTapped(_ sender: UIButton) {
        
        // An operation was tapped, so the next input will be a fresh number
        clearDisplay = true
        
        // checks to see if the user has a number ready
        if isValidPress == true {
            
            print(logicManager.calculationArray)
            
            // checks if the number is a already calculated value
            if logicManager.calculationArray.count == 1 {
                // if it is, we append the operation to the calculation array, right after the calculated number
                // [10, 0.0, 5] -> [15] -> [15, our operation]
                logicManager.calculationArray.append(Double(sender.tag))
            }
            // if the calculation array has not been cleared, we are beginning a chain of operations
            else{
                // add the current number into the calculation array
                logicManager.calculationArray.append(logicManager.currentNumber)
                
                // add the selected operation to the calculation array
                logicManager.calculationArray.append(Double(sender.tag))
            }
            print("After: ", logicManager.calculationArray)
            
            total.text = String(logicManager.calculationArray[0])
        }
        
        // save the last operation to our logicManager to keep track of it
        logicManager.lastOperation = Double(sender.tag)
        
        // we are calculating an operation, so pass "operation" as parameter in our logicManagers calculate and return function to get the result of the calculation, if this returns nil, it is because the array does not have at least 3 values, which are needed to run a calculation.
        if let result = logicManager.calculateAndReturn(operation: "operation"){
            total.text = result
        }
        
        isValidPress = false
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        
        isValidPress = true
        
        logicManager.lastNumber = logicManager.currentNumber
        
        if let result = logicManager.calculateAndReturn(operation: "equals"){
            total.text = result
        }
        
        print("equals tapped")
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        print("clear tapped")
        logicManager.currentNumber = 0.0
        logicManager.lastOperation = 0.0
        logicManager.lastNumber = 0.0
        logicManager.calculationArray = []
        total.text = ""
    }
    
    
    @IBAction func decimalTapped(_ sender: UIButton) {
        
        if !total.text!.contains("."){
            total.text?.append(".")
        }
        else{
            print("You already added one, this isnt an ip address boiii")
        }
        
    }
    
    
}

