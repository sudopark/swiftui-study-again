
## Group
: group인스턴스를 사용하여 여러 뷰를 하나의 인스턴스로 그루핑할 수 있음(HStack, VStack, Section과 다르게)
- group 생성이후에 멤버로 어느 뷰나 집어넣을 수 있고 아래의 경우에는 3개의 텍스트에 동시에 헤드라인폰트가 적용됨

```
Group {     // viewBuilder로 만들기 떄문에 다른것들과 동일
    Text("t1")
    Text("t2")
    Text("t3")
}
.font(.headline)
```swift


## List
: 하나의 칼럼에 해당하는 리스트 데이터를노출, 하나 이상의 멤버를 선택 가능
```
struct List<SelectionValue, Content> where SelectionValue: Hashable, Content: View
```swift

#### Creating a List with Arbitrary Content
```
init(content: () -> Content) where Select == Never, Content: View
// content에는 viewbuilder 들어가는듯?

init(selection: Binding<SelectionValue?>?, conetnt: () -> Content)
// 단일 선택 리스트 생성

init(selection: Binding<Set<SelectionValue>>?, content: () -> Content)
// 여러 row 선택 가능한 리스트 생성
```swift

#### Creatign a List from a Range

```
init<RowContent>(Range<Int>, rowContent: @escaping (Int) -> RowContent) where SelectionValue == Never, Content == ForEach<Range<Int>, Int, RowcContent>, RowContent: View
// range로 list 생성 

// 단일, 다중 선택의 경우도 있음
```swift

#### Creating a List from Identifiable Data
```
init<Data, RowContent>(Data, rowContent: (Data.Element) -> RowContent)
where Content == ForEach<Data, Data.Element.ID, RowContent>, Data: RandomAccessCollection, RowContent: View, Data.Element: Identifiable
// element가 Identifiable인 RandomAccessCollection을 이용하여 content(ForEach) 생성
```

#### Creating a List from Data and an Identifier
```
protocol Identifable {
    associatedtype ID: Hashable
    // ID로 구분
}
// class 타입의 경우 ObjectIdentifier를 이용하여 디폴트 기본 제공

init<Data, ID, RowContent>(Data, id: KeyPath<Data.Element, ID>, rowContent: (Data.Element) -> RowContent) where ID: Hashable
// Data.elemebt가 Identifiable이 아닌경우에 Hashable인 ID를 Data.Element에서 keypath로 제공
```

#### Creating a List from a Bindind to Identifiable Data
```
init<Data RowContent>(Binding<Data>, rowContent: (Binding<Data.Element>) -> RowContent)
where Content == ForEach<LazyMapSequence<Data.Indices, (Data.Index, Data.Element.ID)>, Data.Element.ID, RowContent>,
    Data: MutableCollection, Data: RandomAccessCollection,
    RowConten: View, Data.Element: Identifiable, Data.Index: Hashable
// element가 Identifiable인 Binding<Data>로 생성
```

나머지 생성자는 생략

### Supporting Selection in Lists
- 리스트를 선택가능하게하기위해 selection 변수에 대한 binding을 제공. 
```
@Statte private var multiSelection = Set<Int>()

var body: some View {
    NavigationView {
        List(Array(0..<10), selection: $multiSelection) {
            Text("\($0)")
        }
        .navigationTitle("dd")
        .toolbar { EditButton() } 
    }
    Text("\(multiSelection) selections")
}
```swift 


## NavigationLink => 생략
