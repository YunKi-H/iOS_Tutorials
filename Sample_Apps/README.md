# SwiftUI Sample Apps

## About Me

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

## Date Planner

### @StateObject vs @ObservableObject
View 자체는 여러번 재생성될 수 있으므로 View 내부에서 ObservableObject를 생성하는건 안전하지 않음 -> @StateObject 프로퍼티 래퍼로 ObservableObject 객체가 한번만 생성되어 사용될 수 있도록 보장

## Organizing with Grids

### LazyVGrid
- 내부 요소를 필요할 때까지 생성하지 않음(메모리절약)
- 인자로 (columns:) 를 받음 (가로로 몇칸일지 결정)
- 내부에서 각각의 Grid에 들어갈 item들을 정의함(ForEach 등)

## Editing Grids

### Identifiable

Grid나 List 내부에서 ForEach등으로 View들을 구성할 때 각 개체를 구분지을수 있게 해주는 프로토콜

'id' 프로퍼티가 요구됨

### Edit Mode
View 내부에 @State로 플래그 변수를 하나 설정함으로써 Edit모드 - 일반모드 전환 가능

-> 다른 방법은 없나..?

## Image Gallery

### AsyncImage
- image를 비동기적으로 로드함
    -> 앱 실행시 많은 이미지를 불러올 때 앱이 멈추는것 방지
- placeholder
    -> 로딩중에 보여줄 View 설정 가능

### GeometryReader
부모 View의 크기를 하위 View에서 사용하기 위해 하위 View를 감싸서 사용

## Laying Ouy Views
- Organize your views in different configurations using container views.
- Fine tune the sizing, spacing, alignment, and positioning of your views.
- Debug your views when something goes wrong.

### View
view는 다른 view들을 담고 구성하는 container의 역할을 할 수 있음. ex) VStack

### Shape
Shape 뷰들은 남아있는 container의 공간을 채우기 위해 확장됨

### Stack
- VStack: view들을 세로로 나열
- HStack: view들을 가로로 나열
- ZStack: view들을 z축(겹쳐서)으로 나열

### View's Size
View 들을 기본적으로 container역할을 하는 부모 view의 크기에 따라 size를 결정함

모든 view들이 같은 크기의 공간을 필요로 하는게 아니라 각각 다름

### .frame()
view가 차지하는 공간을 최적화하기위해 사용하는 modifier

상수값을 설정하는건 view의 적응력을 제한하기 때문에 width, height 보다 maxWidth, minHeight 등을 사용하는게 나음

### .resizable
Image view가 resize 가능하게 만들어 .frame() modifier에 따라 크기가 변할 수 있도록 함 (적용하는 순서 중요)

### .scaledToFill() .scaledToFit()
이미지가 원본에 비해 늘려진것처럼 보일 수 있기 때문에 .frame 대신 사용을 권장

### .font()
Text 의 속성을 변경하기 위해 사용 (굵기, 폰트, 색상, ...)

### alignment
VStack, HStack, ZStack 등의 View에게 파라미터로 alignment: 를 넘겨주어 정렬 설정 가능
- VStack
    - .leading
    - .center: default
    - .trailing
- HStack
    - .top
    - .center: default
    - .bottom

.frame() 적용시 .frame()의 modifier에 파라미터로 alignment: 를 넘겨주는식으로도 설정 가능

### Spacer
아무것도 안하지만 공간을 차지해주는 view (차지할 공간이 없으면 render되지 않음)

### spacing
Stack 들의 내부 view들 사이에 spacing 파라미터를 사용해 공간을 설정할 수 있음

### Debug
view마다 border 걸어서 뭐가 잘못된건지 찾기 -> print 찍어보는거랑 비슷한 느낌..

## Meme Creator
비동기 데이터 처리

### Fetcher: ObservableObject
data를 fetch해왔을때 해당 data를 view에 실시간으로 업데이트해줄수 있기 때문에 observableobject 채택

### async await
비동기 함수의 선언부에 async 를 붙여 비동기로 작동할것을 알림

비동기 함수를 호출할 때 await 를 붙여 해당 함수를 기다릴 것을 표기?

### throw
실패 가능성 있는 함수의 선언부에 throw 키워드를 붙여줌

외부에서 함수 호출시 try 키워드와 함께 호출

### 네트워크 데이터 fetch 코드
```swift
let urlString = "http://playgrounds-cdn.apple.com/assets/pandaData.json"
    
enum FetchError: Error {
    case badRequest
    case badJSON
}

func fetchData() async throws {
    guard let url = URL(string: urlString) else { return }

    let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }


    Task { @MainActor in
        imageData = try JSONDecoder().decode(PandaCollection.self, from: data)
    }
}
```

### AsyncImage 사용 코드
```swift
AsyncImage(url: imageMetadata.imageUrl) { phase in 
    if let image = phase.image {
        image
    }  else if phase.error != nil  {
        Image("pandaplaceholder")
    } else {
        ProgressView()
    }
}
```

### .task {}
view가 처음 나타날때 수행될 task들을 정의하는 modifier

## Bubble Level
Access and display divice sensor data

### CoreMotion
```swift
import CoreMotion
```
accelerometers, gyroscopes 등의 센서에 접근 가능하게 해주는 프레임워크

센서 data 얻기 위해 CMMotionManager 객체 사용

예시
```swift
private let motionManager = CMMotionManager()

@Published var pitch: Double = 0
@Published var roll: Double = 0
@Published var zAcceleration: Double = 0

func start() {
    UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    orientationObserver = NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] _ in
        switch UIDevice.current.orientation {
        case .faceUp, .faceDown, .unknown:
            break
        default:
            self?.currentOrientation = UIDevice.current.orientation
        }
    }
    
    if motionManager.isDeviceMotionAvailable {
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
            self.updateMotionData()
        }
    } else {
        print("Motion data isn't available on this device.")
    }
}

func updateMotionData() {
    if let data = motionManager.deviceMotion {
        (roll, pitch) = currentOrientation.adjustedRollAndPitch(data.attitude)
        zAcceleration = data.userAcceleration.z
        
        onUpdate()
    }
}
```

## Seismometer (지진계)
진동감지

위에서 만든 MotionDetector class의 zAcceleration 사용해서 진동에 따라 움직이는 바늘, 그래프 표현

### .onAppear .onDisappear
- .onAppear: view가 처음 나타날 때 수행될 액션
- .onDisappear: view를 볼 수 없어질 때 수행될 액션

## Recognizing Gestures
Update shapes or other content in response to taps, rotations, or other Multi-Touch gestures.
- TapGesture()
- LongPressGesture()
- DragGesture()
- RotationGesture()


### custom Gesture
```swift
var tapGesture: some Gesture {
    TapGesture()
        .onEnded {
            withAnimation {
                color = Color.random()
            }
        }
}

var longPressGesture: some Gesture {
    LongPressGesture()
        .onEnded { value in
            withAnimation {
                sizeIndex += 1
                if sizeIndex == sizes.count {
                    sizeIndex = 0
                }
            }
        }
}

var dragGesture: some Gesture {
    DragGesture()
        .onChanged { value in
            offset = CGSize(width: value.startLocation.x + value.translation.width - circleSize/2,
                            height: value.startLocation.y + value.translation.height - circleSize/2)
        }
}

var rotationGesture: some Gesture {
    RotationGesture()
        .onChanged{ angle in
            rotation = angle
        }
        .onEnded { angle in
            rotation = angle
        }
}

```

### .gesture
View에 적용시킬수 있는 modifier로 Gesture를 인자로 받음

## Animating Shapes
Learn how to use shapes and simple animations in SwiftUI.

### Path()
Shape를 커스텀하기 위헌 도구

Path() 객체에 .move로 시작점을 설정 후 .move, .addCurve, .addArc, .addLine 등으로 원하는 모양을 그림

### withAnimation() {}
withAnimation의 클로저 안쪽에서 @State 변수를 변경함으로써 지정한 애니메이션 구현

### .animation()
view에 value의 변화에 따라 지정한 animation을 적용시켜주는 modifier