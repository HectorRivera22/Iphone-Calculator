//
//  ContentView.swift
//  Iphone Calculator
//
//  Created by StudentAM on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var firstNumber: String = ""
    @State private var operation: String = ""
    @State private var secNumber: String = ""
    @State private var display: String = "0"
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text("\(display)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 75))
                }
                ForEach(numsAndOperations, id:\.self){ row in
                    HStack{
                        ForEach(row, id:\.self){text in
                            if text == "÷" || text == "x" || text == "-" || text == "+" || text == "="{
                                Button(text, action: {handleClick(button: text)})
                                    .frame(width:40, height:40)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(60)
                            }
                            
                            else if text == "AC" || text == "+/-" || text == "%" || text == "C"{
                                Button(text, action: {handleClick(button: text)})
                                    .frame(width:40, height:40)
                                    .padding()
                                    .background(Color(UIColor.lightGray))
                                    .foregroundColor(.black)
                                    .cornerRadius(60)
                            }
                            else {
                                if text != "0" {
                                    Button(text,action:{changeDisplay(number:text)})
                                        .frame(width:40, height:40)
                                        .padding()
                                        .background(Color(UIColor.darkGray))
                                        .foregroundColor(.white)
                                        .cornerRadius(60)
                                }
                                else {
                                    Button(text,action:{changeDisplay(number:text)})
                                        .frame(width:111, height:40)
                                        .padding()
                                        .background(Color(UIColor.darkGray))
                                        .foregroundColor(.white)
                                        .cornerRadius(60)
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    func changeDisplay(number:String){
        numsAndOperations[0][0] = "C"
        if display.count < 9{
            if display == "0"{
                display = number
            }
            else{
                display += number
            }
        }
    }
    func handleClick(button:String){
        if button == "AC" || button == "C"{
            display = "0"
            numsAndOperations[0][0] = "AC"
        }
        else if button == "+/-"{
            if let currentNumber = Int(display) {
                display = String(currentNumber * -1)
            }
        }
        else if button == "%"{
            if let currentNumber = Double(display){
                display = String(currentNumber * 0.01)
            }
        }
        else if button == "÷" || button == "x" || button == "-" || button == "+" {
            firstNumber = display
            display = "0"
            operation = button
            
        }
        else if button == "="{
            secNumber = display
            doMath()
            
        }
    }
    func doMath() {
        if firstNumber.contains(".") || secNumber.contains("."){
            if let num1 = Double(firstNumber) , let num2 = Double(secNumber){
                if operation == "+"{
                    display = String (num1 + num2)
                    
                }
                else if operation == "-"{
                    display = String (num1 - num2)
                }
                else if operation == "x"{
                    display = String (num1 * num2)
                }
                else {
                    display = String (num1 / num2)
                }
            }
        }
        else {
            if let num1 = Int(firstNumber) , let num2 = Int(secNumber){
            if operation == "+"{
                display = String (num1 + num2)
                
            }
            else if operation == "-"{
                display = String (num1 - num2)
            }
            else if operation == "x"{
                display = String (num1 * num2)
            }
            else {
                display = String (num1 / num2)
            }
            }
        }
    }
}


#Preview {
    ContentView()
}
