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
>>> 4. Settings

### View: 화면에 보이는 시각적 요소를 정의하는 프로토콜 / 다른 View로 구성되어 계층구조를 이룸

### VStack / LazyVStack: 하위 View를 수직적으로 구성 <-> HStack / LazyHStack (Horizontal)
>> LazyVStack은 View가 화면에 표시되어야 할 때만 렌더링 -> 성능향상

### Image(systemName: String) -> SF Symbols에 근거한 아이콘 출력