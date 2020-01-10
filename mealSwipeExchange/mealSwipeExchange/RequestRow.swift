

import SwiftUI

struct RequestRow: View {
    var request: String
    var name: String

    var body: some View {
        HStack {
            Text(name)
                .padding(.trailing, 100.0)
            Text(request)
        }
    }
}

struct RequestRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestRow(request: "Hill", name: "Jerry Ye")
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
