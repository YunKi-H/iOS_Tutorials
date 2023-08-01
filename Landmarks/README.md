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