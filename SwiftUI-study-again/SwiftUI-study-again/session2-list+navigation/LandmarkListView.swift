//
//  LandmarkListView.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/02/05.
//

import SwiftUI

struct LandmarkListView: View {
    
    @State private var multiSelection = Set<Int>()
    
    var body: some View {
//        List {
//            LandmarkRowView(landMark: .dummy(0))
//            LandmarkRowView(landMark: .dummy(1))
//        }
        
//        List(Landmark.makeDummies(size: 10)) {
//            LandmarkRowView(landMark: $0)
//        }
        
//        List(Landmark.makeDummies(size: 10), id: \.id) {
//            LandmarkRowView(landMark: $0)
//        }
        
        NavigationView {
            VStack {
                List((0..<10), selection: $multiSelection) { int in
                    NavigationLink {
                        
                    } label: {
                        Text("\(int)")
                    }
                }
                .navigationTitle("title")
                .toolbar { EditButton() }
                
                Text("selected => \(multiSelection.map { "\($0)" }.joined(separator: ",") )")
            }
        }
        
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView()
    }
}


extension Landmark: Identifiable {
    
}
