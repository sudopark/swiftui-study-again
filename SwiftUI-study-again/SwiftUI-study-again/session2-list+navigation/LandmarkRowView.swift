//
//  LandmarkRowView.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/02/04.
//

import SwiftUI

struct LandmarkRowView: View {
    
    var landMark: Landmark
    
    var body: some View {
        HStack {
            landMark.image
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(landMark.name)
            
            Spacer()
            
            if landMark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRowView_Previews: PreviewProvider {
    
    private static let dummies = Landmark.makeDummies(size: 10)
    
    static var previews: some View {
        Group {
            LandmarkRowView(landMark: self.dummies[0])
            LandmarkRowView(landMark: self.dummies[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}



extension Landmark {
    
    var image: Image {
        return Image("sample")
    }
}
