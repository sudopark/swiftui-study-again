//
//  LandmarksView.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/01/31.
//

import SwiftUI

struct LandmarksView: View {
    var body: some View {
        VStack {
            
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CirclrImage()
                .offset(y: -130)
                .frame(width: 260, height: 260)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("title")
                    .font(.title)
                
                HStack {
                    Text("subheadline")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct LandmarksView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarksView()
.previewInterfaceOrientation(.portrait)
    }
}
