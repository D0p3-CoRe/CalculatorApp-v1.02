import SwiftUI

struct CalculatorButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(label)
                .font(.title)
                .frame(width: 70, height: 70)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(35)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1") {
            print("Button pressed")
        }
    }
}

