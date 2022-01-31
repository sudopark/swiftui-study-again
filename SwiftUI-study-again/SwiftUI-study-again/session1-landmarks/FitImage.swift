//
//  FitImage.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/01/31.
//

import SwiftUI

struct FitImage: View {
    var body: some View {
        Image("sample")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 400, alignment: .topLeading)
            .border(.blue)
            .clipped(antialiased: true)
    }
}

struct FitImage_Previews: PreviewProvider {
    static var previews: some View {
        FitImage()
    }
}
