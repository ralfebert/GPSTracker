import SwiftUI

struct CircleButtonView: View {
    var imageName: String
    var action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue.clipShape(Circle()))
            }
        )
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(imageName: "trash") {}
            .previewLayout(.sizeThatFits)
    }
}
