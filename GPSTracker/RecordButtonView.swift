import SwiftUI

struct RecordButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                ZStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 48, height: 48)
                    
                    Circle()
                        .strokeBorder(.gray, lineWidth: 3)
                        .frame(width: 60, height: 60)
                }
            }
        )
    }

}

struct RecordButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton(action: {})
            .previewLayout(.sizeThatFits)
    }
}
