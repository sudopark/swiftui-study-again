# App
- App protocol을 따르게해 app structure를 만들 수 있음
- @main attribute를 이용해 앱의 진입점을 표시 + 프로토콜은 또한 main default implementation을 제공 => 이거 재정의하면 어케됨
- 앱은 1개의 진입점만 존재 가능
- body에 app의 content를 정의 + scene을 따르는 인스턴스로 구성
- 각각의 Scene은 rootView를 포함함. 그리고 이들의 life-cycle은 system에 의해 관리됨
- swiftUI는 default scene을 제공하고 커스텀 scene을 만들수도 있음
- StateObject를 이용하여 상태를 만들고 이들을 앱의 컴포넌트들에 공유할 수 있음 -> 이를 ObservedObject로 view에 제공 or EnvironmentObject로 제공
```
@main
struct Mail: App {
    @StateObject private var model = MailModel()
    
    var body: some Scene {
        
        WindowGroup {
            MailViewer()
                .environmentObject(model)   // environment를 통해 전달
        }
        
        Settings {
            SettingView(model: model)       // observed object로 전달
        }
    }
}
```swift
### 의문점
- swiftUI는 view에서 직접적으로 상태를 다루는 튜토리얼들이 많음 -> uiKit의 MVC에서 vc가 상태를 관리하는거는 그렇다 치지만 왜 예제에서는 view가 상태를 다루는식으로 드는것인가
- ui 상태말고 주요 데이터들은 vm이 관리한다고 치면, 여기서 변환된 상태로 view가 다시 그려잠  
- App 구조로 앱을 구성할때, app에서 제공하는 dependency로 app의 라이프사이클 내에서 view를 그려야할때 vm을 만들고 view도 그려짐, vm 소유는 누가? 



#  UIHostingController

- swiftUI 뷰를 UIKit 뷰 하이라키에 포함시키고 싶을때 사용
- 사용하고자하는 swiftUI view를 rootView로 지정, 그리고 나중에 rootView property를 수정할수도 있음
- UIKit 체계에서 여느 uiViewController 처럼 사용가능 -> 차일드를 임베드했다 생각해도됨  
- hostingview의 주요 역할이 swiftUI view를 임베드하는(그리는) 역할이였다면 제네릭할 필요가 있었을까? + rootView 레퍼런스가 필요?
```
open class UIHostingController: UIViewController {
   
    func reDrawView() -> some View { ... }
} 
```swift
 


# Text


### 생성 및 속성
- 스탠다드 폰트 사용 가능 + 커스텀도 가능 => title,  caption, body ....
- bold나 italic으로 포맷조절 가능
- text에 AttributeString 값으로 생성 가능


### 위치 및 크기
- 텍스트는 기본으로 컨텐사이즈를 지님 => 하지만 frame으로 수정 가능
- 제공되는 frame에 컨텐츠를 다 그리지 못한다면 다음의 값들이 조정됨
- lineLimit(_:) -> 라인수를 지정해 라인 이상의 텍스트는 말줄임 표시됨
- allowsTightening(_:) -> 1줄로 표시할때 자간을 줄일지 여부를 결정 => lineLimit(1)아니면 무쓸모인데 이런거 컴파일러로 제한 못함?
- truncationMode(_:) 말줄임 위치 결정
- minimumScaleFactor(_:) -> 주어진 공간에 맞추기 위해 글자크기 최대로 작아질 수 있는 비율


### 제한사항
- text의 고유 속성을 조절해도 리턴은 some view로 되어서 재사용이 제한됨.. 아래와 같은거 불가 
```
import SwiftUI

struct LandmarksView: View {
    var body: some View {
        VStack {
            self.makeText()
                .allowsTightening(true)
            
            self.makeText()
                .allowsTightening(false)
            
            self.makeText()
                .truncationMode(.middle)
        }
    }
    
    func makeText() -> Text {
        Text("This is a wide text element")
            .font(.body)
            .italic()
            .foregroundColor(Color.red)
//            .padding(.horizontal, 30)
//            .padding(.vertical, 10)
            .frame(width: 200, height: 50)
            .lineLimit(1)   // Cannot convert return expression of type 'some View' to return type 'Text'
    }
}

struct LandmarksView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarksView()
    }
}

```swift


# Spacer
- containing뷰에서 차지 가능한 최대 영역만큼 늘어남


# Image
- asset library나 bundle에 있는 이미지 파일
- 플랫폼 특화된 이미지(NSImage, UIImage), CGImage
- SF Symbol을 이용한 시스템 이미지
- 들을 지원

## Fitting Images info Available Space
- view modifier를 이용하여 이미지의 사이즈와 모양을 조정

### Scale a Large Image to Fit its Container Using Resizing
- 4032x3024 사이즈의 이미지가 있다고할떄 다음과같이 Image에 바로 올리면 전체 이미지의 좌측상단 300x400 크기만 잘리게됨
```
Image("image name")
    .frame(width: 300, height: 400, alignment: .topLeading)
    .border(.blue)
```swift

### resizable(capInset: resizingMode:)
- 현재의 view에 맞도록 이미지를 리사이징 시킴
- 디폴트로 컨테이너보다 크면 줄이고, 작으면 늘림
- 이는 기본적으로 각 축을 독립적으로 조정시킴

### aspectRatio(_:contentMode:)
- 리사이징할때 어떻게 리사이징 할것인지를 결정
- 이미지의 본래 비율을 유지시킴
- fill로 컨텐츠모드 정의시 이미지가 프레임보다 크게 커질수있음

### clipped(antialiased:)
- antialiased 기본적으로 false

## Use Interpolation Flags to Adjust Rendered Image Quality
-> 이미지 사이즈 작은거에 보간법쓸일 거의없음, 필요하면 나중에
