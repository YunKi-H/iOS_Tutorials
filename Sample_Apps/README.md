# SwiftUI Sample Apps

## Navigating Apps

### TabView
- Tab으로 구성된 UI
- 각 Tab에 보여주고자 하는 View를 TabView 내부에 구현
- 첫번째 View가 App에 진입시 보일 화면
- .tabItem() modifier: 각 탭의 Label 표기
- .tabItem{} 내부엔 Label, Text, Image만 받음 -> Button같은 view는 빈 tab item으로 표기됨

### .resizeable()
Image view가 화면에서 가용 공간을 점유할 수 있게 만들어줌.

### ScrollView
text가 너무 길때 스크롤시키고싶다면 Text뷰를 ScrollView로 감싸라
-> 얼마나 길때 스크롤되는지?

## Choose Your Own Story

### subscript (aka Index)
구조체에 index로 접근하고자 할 때 subscript(Int) {} 메서드 구현
```swift
struct Story {
    
    let pages: [StoryPage]


    subscript(_ pageIndex: Int) -> StoryPage {
        return pages[pageIndex]
    }
}

let story = Story()
print(story[0])
```

### NavigationStack
NavigationStack 내부의 View를 담고 있는 Container로서 동작하고 NavigationLink를 tap하면 해당 view로 transition됨

### NavigationLink
최상단의 NavigationStack 내부의 어디에서든지 NavigationLink() 사용해서 해당 view로 전환할 수 있음

### .navigationTitle()
이전엔 왜 NavigationStack에 안달고 내부 View에 직접 달아야 작동하나 의문이었는데
Stack에 쌓이는 View마다 다른 타이틀을 적용할 수 있어야 하니까 그런듯?