# SwiftUI Concepts

Explore the project for the [Exploring the structure of a SwiftUI app](https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app) tutorial.

## App principles

### SwiftUI 사용을 위해 SwiftUI import 선언 필요
```swift
import SwiftUI
```

### App의 시작점에 @main attribute 적용
>> @main은 앱 하나에 하나만 존재해야 함

### App의 content와 동작을 제공하는 App 프로토콜을 채택한 구조체

### App 프로토콜은 computed property인 body 변수 요구
>> body 변수는 View 계층구조를 포함하는 Scene을 리턴함
>>> Scene의 종류
>>> 1. WindowGroup
>>> 2. Window
>>> 3. DocumentGroup
>>> 4. Settings -> macOS전용 (앱의 설정 화면 구성)

### View: 화면에 보이는 시각적 요소를 정의하는 프로토콜 / 다른 View로 구성되어 계층구조를 이룸

### VStack / LazyVStack: 하위 View를 수직적으로 구성 <-> HStack / LazyHStack (Horizontal)
>> LazyVStack은 View가 화면에 표시되어야 할 때만 렌더링 -> 성능향상

### Image(systemName: String) -> SF Symbols에 근거한 아이콘 출력

### 매크로를 통해 os(macOS, iOS, watchOS ...)별 코드 분리 가능
```swift
#if os(iOS)
  code
#elseif os(macOS)
  code
#endif
```

### App - Scene - View

## Maintaining the adaptable sizes of built-in views

### Text
- read-only text
- String을 인자로 받음
- Font에 따라 화면에서 차지하는 크기가 결정됨

### Symbols
- SF Symbols제공
- 사용자에게 인식되기 쉬운 icon
- Image(systemName: String) 사용
- 'Font' modifier로 size, weight 변경 가능

### Labels
- text와 symbol을 하나의 객체로 표시하기 위해 사용
- LabelStyle로 표시되는 형식 설정

### Controls
- 설정창같이 동일한 여러 객체를 나타내기 위해 일정한 크기로 제공됨
- Controls는 클릭하거나 탭하기 충분한 크기여야 함
- controlSize(_:) 로 size 변경 가능
- Picker, Button, Menu, Link, EditButton, ColorPicker 등 존재

### Images
- 기본적으로 asset의 원본 사이즈로 표현됨
- resizable(capInsets: resizingMode:), scaledToFit() 등의 modifier들을 통해 편집 가능
- server로부터 이미지를 접근할 시 AsyncImage()를 사용해 앱의 반응성 유지

### Shapes
- Rectangle(): 사각형
- Circle(): 원
- RoundedRectangle(): 둥근 사각형
- foregroundStyle() 로 색상설정, frame()으로 크기 설정 가능
- 기본적으로 가능한 가장 큰 공간 점유

## Scaling views to complement text

- Capsule(): Shape - 캡슐모양

### Label .background(.purple, Capsule())
ZStack(){} 사용할 줄 알았는데 틀렸음

### @ScaleMetric property wrapper: 다양한 font size에 대비해야 할 경우 각 케이스마다 다른 수치를 적용하는 대신 사용
```swift
struct KeywordBubble: View {
    let keyword: String
    let symbol: String
    @ScaledMetric(relativeTo: .title) var paddingWidth = 14.5
    var body: some View {
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding(paddingWidth)
            .background {
                Capsule()
                    .fill(.purple.opacity(0.75))
            }
    }
}
```
font .title에 연관된 변수를 14.5로 설정시 dynamicTypeSize 에 따라 동적으로 바뀜
ex) 사용자가 글씨 크기를 키우면 paddingWidth == 20 으로 늘어나는 효과

## Layering content

### Define an overlay
- ZStack() {}: 스택 내부의 다른 view들에 대한 고려 없이 각각의 view의 자체 크기대로 할당
- .overlay(alignment:content:): view의 앞에 쌓임 + 기존의 view와 같은 크기(default)
- .background(_:in:fillStyle): view의 뒤에 쌓임 + 기존의 view와 같은 크기(default)

### .clipShape
view의 모양을 size나 position을 변경하지 않고 clipping함

### .padding()
해당 view의 edge와 그 view를 담고있는 view 사이에 공간 추가

Q) 특정 view의 구조체 내부에서 padding을 적용시켜 사용하는것 vs 특정 view를 호출할때 외부에서 padding을 사용하는것 장단점?

## Choosing the right way to hide a view

### Conditionally removing a view
- .opacity(_:): 투명하게 만들어서 - 자리는 그대로 차지
- .overlay(alignment:content:): 다른걸로 덮어서 - 자리는 그대로 차지
- Form: 사용자의 선택에 따라 표시되는 set을 달리해서 - 필요에 따른 자리 차지
- if: 조건에 따라 view가 표시되는 공간이 바뀔때 - 필요에 따른 자리 차지
- hidden(): 공간은 차지하지만 view는 보여주고싶지 않을때

## Organizing and aligning content with stacks

### HStack(alignment:)
- .top
- .firstTextBaseline
- .center
- .lastTextBaseline
- .bottom

### VStack(alignment:)
- .leading
- .center
- .trailing
- .listRowSeparatorLeading
- .listRowSeparatorTrailing

## Adjusting the space between views
- Spacer(): 그 자체로 view면서 공간을 차지하는 역할
- .padding(_:_:): modifier로서 공간을 만들어줌

### SwiftUI의 built-in collection view들은 기본적으로 내부의 subview들 사이에 space를 적용함
HStack(spacing:) 매개변수로 space의 크기를 커스텀 가능

