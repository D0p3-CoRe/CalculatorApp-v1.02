import Foundation

class CalculatorModel: ObservableObject {
    @Published var display: String = "0"
    
    private var firstNumber: Double? = nil
    private var currentOperation: String? = nil
    
    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9", ".":
            if display == "0" || currentOperation != nil {
                display = button
                currentOperation = nil
            } else {
                display += button
            }
        case "+", "-", "*", "/":
            firstNumber = Double(display)
            currentOperation = button
        case "=":
            if let firstNumber = firstNumber, let currentOperation = currentOperation, let secondNumber = Double(display) {
                let result: Double
                switch currentOperation {
                case "+":
                    result = firstNumber + secondNumber
                case "-":
                    result = firstNumber - secondNumber
                case "*":
                    result = firstNumber * secondNumber
                case "/":
                    result = firstNumber / secondNumber
                default:
                    return
                }
                display = "\(result)"
                self.firstNumber = nil
                self.currentOperation = nil
            }
        default:
            break
        }
    }
}

