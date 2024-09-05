import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "" // Zmienna przechowująca wyświetlane działanie
    @State private var currentExpression: String = "" // Zmienna przechowująca bieżące działanie matematyczne

    let buttons: [[String]] = [
        ["C", "(", ")", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(displayText)
                    .font(.system(size: 36))
                    .foregroundColor(.black)
                    .padding()
            }
            .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .background(self.buttonColor(button: button))
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(button: button) / 2)
                        }
                    }
                }
            }
        }
    }

    private func buttonTapped(_ button: String) {
        switch button {
        case "C":
            displayText = ""
            currentExpression = ""
        case "=":
            calculateResult()
        case "+", "-", "*", "/", "(", ")":
            displayText += " \(button) "
            currentExpression += button
        default:
            displayText += button
            currentExpression += button
        }
    }

    private func calculateResult() {
        let expression = NSExpression(format: currentExpression)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            displayText = "\(result)"
            currentExpression = "\(result)"
        } else {
            displayText = "Error"
            currentExpression = ""
        }
    }

    private func buttonColor(button: String) -> Color {
        if button == "=" {
            return .orange
        } else if button == "C" {
            return .red
        } else if ["+", "-", "*", "/", "(", ")"].contains(button) {
            return .blue
        } else {
            return .gray
        }
    }

    private func buttonWidth(button: String) -> CGFloat {
        if button == "0" {
            return (UIScreen.main.bounds.width - 5 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }

    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

