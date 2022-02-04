//
//  LandmarkDetailView.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/02/05.
//

import SwiftUI

struct LandmarkDetailView: View {
    var body: some View {
        VStack {
            
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CirclrImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                
                Text("Title").font(.title)
                
                HStack {
                    Text("sub title")
                    
                    Spacer()
                    
                    Text("location")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("about").font(.title2)
                
                Text("desc")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetailView()
    }
}
