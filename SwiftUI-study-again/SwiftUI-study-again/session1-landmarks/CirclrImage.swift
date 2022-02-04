//
//  CirclrImage.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/01/31.
//

import SwiftUI

struct CirclrImage: View {
    var body: some View {
        Image("testimage")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CirclrImage_Previews: PreviewProvider {
    static var previews: some View {
        CirclrImage()
    }
}
