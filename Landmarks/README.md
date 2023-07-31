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
