

import SwiftUI

struct RequestRow: View {
    var request: String
    var name: String
    var time: Date?
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        HStack {
            if time != nil{
                Text("Pairing time: \(time!)")
                    .padding(.trailing, 100.0)
                Text(request)
            }
            else{
                EmptyView()
            }
        }
    }
}

struct RequestRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestRow(request: "Hill", name: "Jerry Ye", time: nil)
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
