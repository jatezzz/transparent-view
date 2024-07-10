import Cocoa

class CustomView: NSView {
    private let visualEffectView = NSVisualEffectView()
    private let transparencySlider = NSSlider(value: 50, minValue: 0, maxValue: 100, target: nil, action: #selector(sliderValueChanged(_:)))
    private let imageView = NSImageView()
    private let imageButton = NSButton()
    private let scrollView = NSScrollView()
    private var initialLocation: NSPoint?

    private let minWidth: CGFloat = 200.0
    private let minHeight: CGFloat = 200.0

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        // Configure and add visual effect view first
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.material = .hudWindow
        visualEffectView.state = .active
        visualEffectView.alphaValue = 0.5
        self.addSubview(visualEffectView)

        // Configure and add scroll view
        scrollView.frame = self.bounds
        scrollView.autoresizingMask = [.width, .height]
        scrollView.hasVerticalScroller = true
        scrollView.documentView = imageView
        self.addSubview(scrollView)

        // Configure and add slider
        transparencySlider.target = self
        transparencySlider.action = #selector(sliderValueChanged(_:))
        transparencySlider.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        self.addSubview(transparencySlider)

        // Configure and add image button
        imageButton.title = "Select Image"
        imageButton.target = self
        imageButton.action = #selector(openImagePicker)
        imageButton.frame = CGRect(x: 20, y: 60, width: 100, height: 30)
        self.addSubview(imageButton)
    }

    @objc func sliderValueChanged(_ sender: NSSlider) {
        let alphaValue = CGFloat(sender.doubleValue) / 100.0
        imageView.alphaValue = alphaValue
        scrollView.alphaValue = alphaValue
    }

    @objc func openImagePicker() {
        let dialog = NSOpenPanel()

        dialog.title = "Choose an image"
        
        dialog.allowedFileTypes = ["png", "jpg", "jpeg"]

        if dialog.runModal() == .OK {
            if let result = dialog.url, let image = NSImage(contentsOf: result) {
                imageView.image = image
                resizeWindowForImage(image)
                visualEffectView.alphaValue = 0
            }
        }
    }

    private func resizeWindowForImage(_ image: NSImage) {
        guard let window = self.window else { return }
        
        let imageSize = image.size
        let newWidth = max(imageSize.width, minWidth)
        let newHeight = max(imageSize.height, minHeight)
        let newSize = NSSize(width: newWidth, height: newHeight)
        
        var frame = window.frame
        frame.size = newSize
        window.setFrame(frame, display: true, animate: true)
        
        scrollView.frame = self.bounds
        imageView.frame = CGRect(origin: .zero, size: newSize)
        imageView.autoresizingMask = [.width]
        visualEffectView.frame = self.bounds
    }

    override func mouseDown(with event: NSEvent) {
        initialLocation = event.locationInWindow
    }

    override func mouseDragged(with event: NSEvent) {
        guard let initialLocation = initialLocation else { return }

        let currentLocation = event.locationInWindow
        let dx = currentLocation.x - initialLocation.x
        let dy = currentLocation.y - initialLocation.y

        if let window = self.window {
            var frame = window.frame
            frame.origin = CGPoint(x: frame.origin.x + dx, y: frame.origin.y + dy)
            window.setFrame(frame, display: true)
        }
    }
}
