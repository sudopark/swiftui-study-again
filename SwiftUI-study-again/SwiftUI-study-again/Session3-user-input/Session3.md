
###  ObservableObject

- object가 변경되기전에 변경을 방출하는 타입
- @Published 프로퍼티 변경시에 objectWillChange publisher(ObservableObjectPublisher)로 이벤트 방출


### EnvironmentObject

- 부모나 조상에서부터 제공받은 observable object를 나타내는 property wrapper
- observable object 뷰 변경시에 현재뷰 invalidates
- environmentObject(_:)로 외부에서 매칭되는 모델을 세팅해줘야하는데 타입 하나만 매칭가능??????


### StateObject
- observable object를 인스턴스화 하는 래퍼?
- 한번만 생성?
