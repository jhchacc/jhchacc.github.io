# Swift Programming for MacOS

I write some random notes regarding macOS here.


### SwiftUI

### Menu Bar App
- How to create a menubar app (MenuBarExtra): https://sarunw.com/posts/swiftui-menu-bar-app/ (unable to render a view)
  - To remove the Dock icon:
    - open Info.plist or open up the Info tab under your app target.
    - Then add a new key `"Application is agent (UIElement)"` (`LSUIElement` flag), and sets the value to `YES`.
- How to assign an AppDelegate to the app: https://sarunw.com/posts/how-to-create-macos-app-without-storyboard/
- How to use `NSPopover` to hook the menu bar: https://github.com/timqian/one-goal/blob/main/OneGoal/AppDelegate.swift

<table>
<td> 

`main.swift` 
</td> 

<td> 

`AppDelegate.swift` 
</td>

<tr>

<td> 

```swift
import SwiftUI

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
_ = NSApplicationMain(
  CommandLine.argc, 
  CommandLine.unsafeArgv)
```
</td> 

<td> 

```swift
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  
  private var statusItem: NSStatusItem!
  private var popover: NSPopover!
  
  @MainActor func applicationDidFinishLaunching(
      _ notification: Notification) {
    // define statusItem
    statusItem = NSStatusBar.system.statusItem(
      withLength: CGFloat(NSStatusItem.variableLength))
    if let button = statusItem.button {
      button.image = NSImage(
        systemSymbolName: "1.circle", 
        accessibilityDescription: "")
      button.action = #selector(togglePopover)
    }
    
    // define popover
    popover = NSPopover()
    popover.contentSize = NSSize(width: 350, height: 100)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(
      rootView: ContentView())
  }
  
  @objc func togglePopover() {
    if let button = statusItem.button {
      if popover.isShown {
        self.popover.performClose(nil)
      } else {
        self.popover.show(
          relativeTo: button.bounds, 
          of: button, 
          preferredEdge: NSRectEdge.minY)
      }
    }
  }
}
```
</td>
</table>

- Interesting examples:
  - https://stackoverflow.com/questions/64949572/how-to-create-status-bar-icon-and-menu-in-macos-using-swiftui

### Global Hotkeys (Shortcuts):
- https://stackoverflow.com/questions/28281653/how-to-listen-to-global-hotkeys-with-swift-in-a-macos-app
- HotKey registry: https://github.com/soffes/HotKey/blob/master/Sources/HotKey/HotKeysController.swift

<details>
<summary> Code snippet </summary>

```swift

  @objc func test() {
    var hotKeyRef: EventHotKeyRef?
    var hotKeyID = EventHotKeyID()
    hotKeyID.signature = OSType(toFourCharCode(stringValue: "swat"))
    hotKeyID.id = UInt32(kVK_Return)

    var eventType = EventTypeSpec()
    eventType.eventClass = OSType(kEventClassKeyboard)
    eventType.eventKind = OSType(kEventHotKeyPressed)

    // Install handler.
    InstallEventHandler(GetApplicationEventTarget(), {
      (nextHanlder, theEvent, userData) -> OSStatus in
      var hkCom = EventHotKeyID()
      GetEventParameter(
        theEvent,
        EventParamName(kEventParamDirectObject),
        EventParamType(typeEventHotKeyID),
        nil,
        MemoryLayout<EventHotKeyID>.size,
        nil,
        &hkCom)
      // Check that hkCom in indeed your hotkey ID and handle it.
      print("hkCom =", hkCom)
      
      NSLog("Cmd + Shift + Return pushed!")
      return noErr
    }, 1, &eventType, nil, nil)

    // Register hotkey.
    // let modifierKeys: UInt32 = toCarbonFlags(cocoaFlags: NSEvent.ModifierFlags.command)
    let status = RegisterEventHotKey(
      UInt32(kVK_Return),  // Return
      UInt32(cmdKey | shiftKey),  // Cmd + Shift
      hotKeyID,
      GetApplicationEventTarget(),
      0,
      &hotKeyRef)
  }
  
  func toFourCharCode(stringValue: String) -> Int {
    var result: Int = 0
    if let data = stringValue.data(using: String.Encoding.macOSRoman) {
      data.withUnsafeBytes({ (rawBytes) in
        let bytes = rawBytes.bindMemory(to: UInt8.self)
        for i in 0 ..< data.count {
          result = result << 8 + Int(bytes[i])
        }
      })
    }
    return result
  }

```

</details>

### MapKit / Locations
- How to use `Map` view in SwiftUI: 
  - https://www.createwithswift.com/using-mapkit-with-swiftui/
  - https://seons-dev.tistory.com/entry/SwiftUI-Map-View
- How to retrieve user's current location: https://medium.com/devtechie/map-user-location-tracking-in-swiftui-dd8821b29e0b
- How to retrieve user's location once: https://www.advancedswift.com/user-location-in-swift/#get-a-user-s-location-once


### Core Location (`CLLocationManager`)

- `CoreLocation` (WWDC'19): https://developer.apple.com/videos/play/wwdc2019/705/
- `CoreLocationUI` (WWDC'21): https://developer.apple.com/videos/play/wwdc2021/10102/
```swift
// Requesting an Authorization prompt
// CLLocationManagers need to have a long lifecycle, so an App Delegate var is ideal
var locationManager = CLLocationManager()
// If you do not need Always authorization, request a prompt for WhenInUse authorization
locationManager.requestWhenInUseAuthorization()
// -- OR --
// If you do need Always authorization, request a prompt for that
locationManager.requestAlwaysAuthorization()
```

- `CoreLocationUI`: https://developer.apple.com/documentation/corelocationui/
  - `LocationButton`
  
### Accessibility
https://developer.apple.com/accessibility/
- Accessibility in Playground: https://www.washington.edu/doit/webinars/?webinar=swift

### Logging
https://developer.apple.com/videos/play/wwdc2016/721/ <br>
https://developer.apple.com/videos/play/wwdc2018/405

### NSWorkspaces
https://developer.apple.com/documentation/appkit/nsworkspace/

### Apple Script and system events
https://developer.apple.com/videos/play/wwdc2018/702/ <br>
` xproject --> Signing & Capabilities --> Hardened Runtime --> check "Apple Events" `
```swift
  var body: some View {
    Button("TEST") {
      Task {
        await createNewWorkspace()
      }
    }
  }

  func createNewWorkspace() async {
    let script = NSAppleScript(source: """
        tell application "System Events"
          do shell script quoted form of "/System/Applications/Mission Control.app/Contents/MacOS/Mission Control"
          click button 1 of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
          do shell script quoted form of "/System/Applications/Mission Control.app/Contents/MacOS/Mission Control"
        end tell
    """)
    
    var errorInfo: NSDictionary?
        script?.executeAndReturnError(&errorInfo)
        if errorInfo != nil {
            print("Error creating new space: \(errorInfo!)")
        }
  }
```

### Etc.

- Quit application: `NSApplication.shared.terminate(nil)`
- How to use `@Published`/`@ObservedObject`: https://www.youtube.com/watch?v=oWZOFSYS5GE&t=2100s
- How to deploy an app: https://jameshfisher.com/2017/08/12/xcode-build-dmg-for-distribution-macos/
- `didFailWithError: Error Domain=kCLErrorDomain Code=0 "(null)"`: https://stackoverflow.com/questions/32543754/ios-9-error-domain-kclerrordomain-code-0-null
- Spaces and Mission Control (Apple guide document): https://support.apple.com/ko-kr/guide/mac-help/mh14112/mac
- Accessibility Inspector (!): https://developer.apple.com/library/archive/documentation/Accessibility/Conceptual/AccessibilityMacOSX/OSXAXTestingApps.html
- Reducing Motion: https://support.apple.com/en-gb/guide/mac-help/mchlc03f57a1/mac
- Disable "App Sandboxing" if any permission issue is encountered: https://stackoverflow.com/a/62552353 
- Picker/Toggle/Slider/Stepper: https://itnext.io/swiftui-picker-toggle-slider-and-stepper-fully-explained-3ad1a273bb4d
- SwiftUI handbook: https://designcode.io/swiftui-handbook-text-view
- Key Symbols: https://gist.github.com/jlyonsmith/6992156f18c423fd1c5af068aa311fb5
- Settings view: https://www.kodeco.com/books/macos-by-tutorials/v1.0/chapters/5-setting-preferences-icons
  - Tabview: https://serialcoder.dev/presenting-the-preferences-window-on-macos-using-swiftui/
