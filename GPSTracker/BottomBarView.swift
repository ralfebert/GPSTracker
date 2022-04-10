import SwiftUI

struct BottomBarView: View {
    var onRecord: () -> Void
    var onDelete: () -> Void
    var onShowList: () -> Void

    var body: some View {
        HStack {
            Group {
                CircleButtonView(imageName: "trash", action: onDelete)
                RecordButton(action: onRecord)
                CircleButtonView(imageName: "list.bullet", action: onShowList)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 1)
    }
}

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

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
            BottomBarView(onRecord: {}, onDelete: {}, onShowList: {})
        .previewLayout(.sizeThatFits)
    }
}
