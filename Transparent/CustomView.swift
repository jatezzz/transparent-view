import Cocoa

class CustomView: NSView {
    private let visualEffectView = NSVisualEffectView()
    private let transparencySlider = NSSlider(value: 50, minValue: 0, maxValue: 100, target: nil, action: #selector(sliderValueChanged(_:)))

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        // Configure visualEffectView
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.material = .hudWindow
        visualEffectView.state = .active
        visualEffectView.alphaValue = 0.5
        self.addSubview(visualEffectView)

        // Configure and add slider
        transparencySlider.target = self
        transparencySlider.action = #selector(sliderValueChanged(_:))
        transparencySlider.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        self.addSubview(transparencySlider)
    }

    @objc func sliderValueChanged(_ sender: NSSlider) {
        let alphaValue = CGFloat(sender.doubleValue) / 100.0
        visualEffectView.alphaValue = alphaValue
    }
}
