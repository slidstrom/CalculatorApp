//
//  LogicManager.swift
//  CalculatorApp
//
//  Created by Spencer Lidstrom on 2/17/22.
//

import Foundation
// [5,0,3] -> [8] -> [8,1,5] -> [3]
class LogicManager {
    
    // Properties we need to keep track of
    var calculationArray = [Double]()
    var lastNumber = 0.0
    var lastOperation = 0.0
    var currentNumber = 0.0
    
    func calculateAndReturn(operation: String) -> String? {
        
        if operation == "operation"{
            if calculationArray.count >= 3{
                let newValue = calculate(firstNumber: calculationArray[0], secondNumber: calculationArray[2], operation: Int(calculationArray[1]))
                calculationArray.removeAll()
                calculationArray.append(newValue)
                calculationArray.append(lastOperation)
                print("Final:", calculationArray)
                return String(calculationArray[0])
            }
        }
        else if operation == "equals"{
            if calculationArray.count >= 1{
                let newValue = calculate(firstNumber: calculationArray[0], secondNumber: lastNumber, operation: Int(lastOperation))
                calculationArray.removeAll()
                calculationArray.append(newValue)
                print("Final:", calculationArray)
                return String(calculationArray[0])
            }
            
        }
        return nil
    }
    
    func calculate(firstNumber:Double, secondNumber:Double, operation: Int) -> Double{
        
        var total = 0.0
        
        switch operation{
        case 0:
            total = firstNumber + secondNumber
        case 1:
            total = firstNumber - secondNumber
        case 2:
            total = firstNumber * secondNumber
        case 3:
            total = firstNumber / secondNumber
        default:
            print("Wrong input given")
        }
        
        return Double(floor(1000*total)/1000)
    }
    
}
