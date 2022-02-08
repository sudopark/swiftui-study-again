//
//  LandmarkListView.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/02/05.
//

import SwiftUI


class LandmarkListViewModel: ObservableObject {
    
    @Published var showOnlyFavorites: Bool = false
    @Published var landmarks = [Landmark]()
    
    var filteredLandmarks: [Landmark] {
        return self.landmarks.filter { self.showOnlyFavorites ? $0.isFavorite : true }
    }
}

struct LandmarkListView: View {
    
    @EnvironmentObject var viewModel: LandmarkListViewModel
    
    var body: some View {
        
        NavigationView {

            List {
                
                Toggle(isOn: $viewModel.showOnlyFavorites) { Text("Favorites Only")}
                
                ForEach(viewModel.filteredLandmarks) {
                    LandmarkRowView(landMark: $0)
                }
            }
            .navigationTitle("title")
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        let marks = (0..<1000).map { int -> Landmark in
            var mark = Landmark(
                id: int, name: "n:\(int)",
                park: "p:\(int)", state: "", description: "",
                coordinate: (0, 0)
            )
            mark.isFavorite = int % 4 == 0
            return mark
        }
        let viewModel = LandmarkListViewModel()
        viewModel.landmarks = marks
        
        let vm2 = LandmarkListViewModel()
        return LandmarkListView()
            .environmentObject(viewModel)
//            .environmentObject(vm2)       // 이거는 씹힘(타입당 하나?) 진짜 개판이네
    }
}


extension Landmark: Identifiable {
    
}
