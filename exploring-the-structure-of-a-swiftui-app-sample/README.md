# SwiftUI Concepts

Explore the project for the [Exploring the structure of a SwiftUI app](https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app) tutorial.

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

