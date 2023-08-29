# SwiftUI Sample Apps

## Navigating Apps

### TabView
- Tab으로 구성된 UI
- 각 Tab에 보여주고자 하는 View를 TabView 내부에 구현
- 첫번째 View가 App에 진입시 보일 화면
- .tabItem() modifier: 각 탭의 Label 표기
- .tabItem{} 내부엔 Label, Text, Image만 받음 -> Button같은 view는 빈 tab item으로 표기됨

### .resizeable()
Image view가 화면에서 가용 공간을 점유할 수 있게 만들어줌