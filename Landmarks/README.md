# https://developer.apple.com/tutorials/SwiftUI

## Creating and Combining Views

### .foregroundColor() -> .foregroundStyle()
    .foregroundColor()가 deprecated될 예정이라 .foregroundStyle()사용

### .clipShape(.circle) vs .clipShape(Circle())
```swift
struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
    }
}
```

```swift
struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(.circle)
    }
}
```
결과는 똑같음

### Map(coordinateRegion: $region) was deprecated in iOS 17

>> 'init(coordinateRegion:interactionModes:showsUserLocation:userTrackingMode:)' was deprecated in iOS 17.0: Use Map initializers that take a MapContentBuilder instead.

```swift
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        Map(coordinateRegion: $region)
    }
}
```

```swift
import MapKit

struct MapView: View {
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    
    var body: some View {
      //another initializer
        Map(position: $cameraPosition)
    }
}
```

### Q. CircleImage()를 VStack과 .offset(y: -130) .padding(.bottom, -130) 을 사용해 겹쳤는데 그냥 ZStack 쓰면 안되나?
>> 아마 지도-이미지-텍스트의 위치지정을 위해서인듯?

### Q. CircleImage()가 MapView()를 안가리는데 VStack의 z축 우선순위는 무슨 순서인가?
```swift
  VStack {
      CircleImage()
          .offset(y: 130)
          .padding(.top, 130)
      
      MapView()
          .frame(height: 300)
      
      CircleImage()
          .offset(y: -130)
          .padding(.bottom, -130)
  }
```
>> 두 원 사이에 지도가 끼워지는걸 봐서 위쪽 View부터 차례로 그려지기 때문애 나중에 그려진 View가 z축 기준 위로 올라가는듯

### Xcode15(iOS17) 에서는 View가 화면 위쪽 SafeArea부분까지 침범함 -> .ignoresSafeArea() 적용시 문제발생

### When creating a custom SwiftUI view, where do you declare the view’s layout?

>> In the body property.
Custom views implement the body property, which is a requirement of the View protocol.

### Which layout renders from the following view code?
```swift
var body: some View {
    HStack {
        CircleImage()
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
            Text("Joshua Tree National Park")
        }
    }
}
```
>> The nested horizontal and vertical stacks arrange the image to the left of the two text views.

### Which of these is a correct way to return three views from a custom view’s body property?
```swift
VStack {
   Text("Turtle Rock")
      .font(.title)
   Divider()
   Text("Joshua Tree National Park")
}
```
>> You can use a stack to return multiple views from a body property.

### Which is the correct way to use modifier methods to configure a view?
```swift
Text("Hello world!")
   .font(.title)
   .foregroundColor(.purple)
```
>> A modifier returns a view that applies a new behavior or visual change. You can chain multiple modifiers to achieve the effects you need.


## Building Lists and Navigation

### [Xcode15] Preview에서 .previewLayout(.fixed(width: 300, height: 70))작동 안함
```swift
#Preview {
    LandmarkRow(landmark: landmarks[1])
        .previewLayout(.fixed(width: 300, height: 70))
}

```
아마 #Preview 매크로 문제인듯

### List의 기본 모양이 문서의 예시와 다름
.listStyle 기본 설정이 .plain -> .insetGrouped 로 바뀐듯?
```swift
List {
    LandmarkRow(landmark: landmarks[0])
    LandmarkRow(landmark: landmarks[1])
}
.listStyle(.insetGrouped)

List {
    LandmarkRow(landmark: landmarks[0])
    LandmarkRow(landmark: landmarks[1])
}
.listStyle(.plain)
```

### MapView 말고 페이지 전체에 .ignoresSafeArew(edges: .top) 적용하니 적용됨
왜지?

### Generate Previews Dynamically 역시 .previewDevice() 적용 안됨
```swift
#Preview {
    LandmarkList()
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
    }
}
```
Xcode15 Canvas가 바뀌면서 달라진듯

.previewDisplayName()도 안됨

### In addition to List, which of these types presents a dynamic list of views from a collection?

>> ForEach
>>> Place a ForEach instance inside a List or other container type to create a dynamic list.

### You can create a List of views from a collection of Identifiable elements. What approach do you use to adapt a collection of elements that don’t conform to the Identifiable protocol?

>> Passing a key path along with the data to List(_:id:).
>>> Pass the key path to a uniquely identifying property for your collection’s elements as the second parameter when creating a List.

### Which type do you use to make rows of a List tappable to navigate to another view?

>> NavigationLink
>>> Provide the destination view and the content of a row when you declare a NavigationLink.

### Which of these choices is not a way to set the device for previewing your views?

- Change the simulator selected in the active scheme.
- Make a different choice in Canvas Settings in Xcode’s preferences.
- Specify one or more devices using the previewDevice(_:) method.
- Connect your development device and click the Device Preview button.

>> Make a different choice in Canvas Settings in Xcode’s preferences.
>>> You can specify the device to use in the active scheme, in code, or by previewing directly on your device. No need for a trip to the preferences!

## Handling User Input

### ModelData: ObservableObject 선언시 final 키워드 사용 이유?
상속할 일이 없다는걸 명시하기 위해?
최적화문제 말고 또다른 장점이 있는지?

### @StateObject를 사용한 Model 선언

App 레벨에서 @StateObject프로퍼티 래퍼로 modelData 객체를 선언해서 화면이 재생성되더라도 객체가 재생성되지 않도록 함

@StateObject 로 modelData 선언 -> 하위 뷰에서는 @EnvironmentObject로 받아서 사용

### Which of the following passes data downward in the view hierarchy?
>> The environmentObject(_:) modifier.
>>> You apply this modifier so that views further down in the view hierarchy can read data objects passed down through the environment.

### What’s the role of a binding?
>> It’s a value and a way to change that value.
>>> A binding controls the storage for a value, so you can pass data around to different views that need to read or write it.

### Which is the correct way to create state for a view?
>> ```swift
>>@State private var showFavoritesOnly = false
>>```
>>> Use the @State property wrapper to mark a value as state, declare the property as private, and give it a default value.

## Drawing Paths and Shapes

### 사실 그래픽을 직접 구현할 일이 많을것 같지는 않음
그냥 해보는데 의의를 두기로

### What is the purpose of GeometryReader?
>> You use GeometryReader to dynamically draw, position, and size views instead of hard-coding numbers that might not be correct when you reuse a view somewhere else in your app, or on a different-sized display.
>>> GeometryReader dynamically reports size and position information about the parent view and the device, and updates whenever the size changes; for example, when the user rotates their iPhone.

### How are views laid out in the following code?
```swift
ZStack {
   Circle().fill(.green)
   Circle().fill(.yellow).scaleEffect(0.8)
   Circle().fill(.orange).scaleEffect(0.6)
   Circle().fill(.red).scaleEffect(0.4)
}
```
>> An image that looks like a target, wich circles of varying sizes layered on top of one another.
>>> ZStack overlays views on top of each other.

### What shape does the following drawing code create?
```swift
Path { path in
   path.move(to: CGPoint(x: 20, y: 0))
   path.addLine(to: CGPoint(x: 20, y: 200))
   path.addLine(to: CGPoint(x: 220, y: 200))
   path.addLine(to: CGPoint(x: 220, y: 0))
}
.fill(
   .linearGradient(
       Gradient(colors: [.green, .blue]),
       startPoint: .init(x: 0.5, y: 0),
       endPoint: .init(x: 0.5, y: 0.5)
   )
)
```
>> A square with a gradient fill.
>>> The path builder automatically adds a fourth line of equal length back to the starting point, creating a four-sided square.

## Animating Views and Transitions

### .animation() modifier와 withAnimation() {} 의 차이가 뭐지?

>> .animation() -> 단일 View에 대해서 애니메이션 처리
>> withAnimation() {} -> 클로저 내부에서 변경되는 값(state)에 영향받는 모든것에 애니메이션 처리

withAnimation() {} 사용이 권장?

### How do you prevent the rotation effect from being animated in the following example?
```swift
Label("Graph", systemImage: "chevron.right.circle")
    .labelStyle(.iconOnly)
    .imageScale(.large)
    .rotationEffect(.degrees(showDetail ? 90 : 0))
    .scaleEffect(showDetail ? 1.5 : 1)
    .padding()
    .animation(.spring(), value: showDetail)
```
>> Pass nil to the animation(_:value:) modifier.
>> ```swift
>> Label("Graph", systemImage: "chevron.right.circle")
>>    .labelStyle(.iconOnly)
>>    .imageScale(.large)
>>    .rotationEffect(.degrees(showDetail ? 90 : 0))
>>    .animation(nil, value: showDetail)
>>    .scaleEffect(showDetail ? 1.5 : 1)
>>    .padding()
>>    .animation(.spring(), value: showDetail)
>> ```
>>> You can animate rotations that you create using the rotationEffect(_:) modifier.

### Why might you pin a preview to the canvas when you’re developing and refining an animation?

>> To keep a particular preview open while you switch between different files in Xcode.
>>> If you don’t pin a preview, the canvas switches to display previews in the file you just opened.

### What’s a quick way to test how an animation behaves during interruptions like state changes?

>> Adjust the duration of the animation so that it runs long enough that you can observe and tune its fine details.
>>> Making animations take longer is a quick and easily reversible change that’s effective for iterating on animations.

## Composing Complex Interfaces

### CaseIterable?
enum의 모든 case들을 .allCases 타입 프로퍼티를 사용해 배열처럼 접근이 가능하도록 만들어주는 프로토콜

### .cornerRadius() will be deprecated
대신 .clipShape() 사용
```swift
landmark.image
    .resizable()
    .frame(width: 155, height: 155)
    .clipShape(RoundedRectangle(cornerRadius: 5))
```

### .listRowInsets(EdgeInset()) ?

화면의 Edge까지 Content가 채워지게 하는 설정?

top, bottom, leading, trailing의 inset을 기본값인 0으로 초기화해주는것 같다.

### Image.renderingMode() ? 

Image를 렌더링할 때 투명픽셀을 처리하는 방식

- .original: 이미지 원본 그대로
- .template: foregroundColor에 맞춰서

### NavigationLink 글자 색상

CategoryItem에서 .foregroundStyle(.primary) 설정했을때는 ContentView에서 파랗게 표시됨

CategoryItem에서 .foregroundColor(.primary) 설정했을때는 ContentView에서 검게 표시됨

### Which view is the root view for the Landmarks app?
>> ContentView
>>> The WindowGroup scene defined in the app body declares ContentView as the root view of the app.

### How does the ContentView view use code from the rest of the app?
>> It connects all of the landmark views in a navigation hierarchy.
>>> The Landmarks app is the sum of all its views, including navigation views.

### What’s the right code to turn a view into a navigation link?
>> ```swift
>> NavigationLink {
>>     LandmarkDetail(landmark: landmark)
>> } label: {
>>     LandmarkCard(landmark: landmark)
>> }
>> ```
>>> Both the destination and the label appear in view builder closures.

## Working with UI Controls

### Badge()를 300*300 으로 생성한 이후 크기를 줄이는 이유?
원하는 해상도를 보장하기 위해

### EditMode

```swift
@Environment(\.editMode) var editMode
```

EditButton()과 연동된 환경변수를 통해 Edit화면 접근

변경사항이 적용되기 전에 global app state가 업데이트되는걸 방지하기 위해(ex. 타이핑마다 업데이트되는것 방지) Editing View는 원본 을 복사해서 제공함

```swift
if editMode?.wrappedValue == .inactive {
    ProfileSummary(profile: modelData.profile)
} else {
    Text("Profile Editor")
}
```

원본 데이터를 ProfileEditor() 뷰가 .onAppear / .onDisappear 될때마다 갱신해줘야한다는건 조금 불편한듯
```swift
ProfileEditor(profile: $draftProfile)
  .onAppear {
      draftProfile = modelData.profile
  }
  .onDisappear {
      modelData.profile = draftProfile
  }
```

### How do you update a view when the editing state changes; for example, when a user taps Done after editing their profile?
>> ```swift
>> struct EditableNameView: View {
>>    @Environment(\.editMode) var mode
>>    @State var name = ""
>>    var body: some View {
>>       TextField("Name", text: $name)
>>          .disabled(mode?.wrappedValue == .inactive)
>>    }
>> }
>> ```
>>> The code checks the edit mode stored in the environment. Storing the edit mode in the environment makes it simple for multiple views to update when the user enters and exits edit mode.

### When do you add an accessibility label using the accessibility(label:) modifier?
>> Add an accessibility label whenever doing so would make the meaning of a user interface element clearer to more users.
>>> Always test your app with VoiceOver on, and then add accessibility labels to your app’s views as necessary.

### What’s the difference between a modal and non-modal view presentation?
>> When you present a view modally, the destination view covers the source view and replaces the current navigation stack.
>>> You present a view modally when you want to break out of your app’s normal flow.

## Interfacing with UIKit

### SwiftUI에서 UIKit View를 가져오기 위해 채택하는 프로토콜 UIViewControllerRepresentable

- 필수 조건
   ```swift
  func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType

  func updateUIViewController(_ uiViewController: Self.UIViewControllerType, context: Self.Context)
  ```

### 이거 그냥 SwiftUI로 작성하면 안되나?
iOS 15 부터 추가된 .tabViewStyle(.page) 사용하면 됨
```swift
struct PageViewTest: View {
    var body: some View {
        TabView {
            FeatureCard(landmark: ModelData().features[0])
            FeatureCard(landmark: ModelData().features[1])
            FeatureCard(landmark: ModelData().features[2])
        }
        .tabViewStyle(.page)
    }
}
```
문제점) 마지막 페이지 이후에 처음페이지로 연결되지 않음