import Foundation
import UIKit

class CercleProgressBar: UIView {
    var color = UIColor.green
    var progress: CGFloat = 0 {
        willSet { progressLayer.strokeEnd = newValue }
    }
    var lineWidth: CGFloat = 10
    
    private let backgroundMask = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        backgroundMask.fillColor = nil
        backgroundMask.lineWidth = lineWidth
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    override func draw(_ rect: CGRect) {
        let cerclePatch = UIBezierPath(ovalIn: rect.insetBy(dx: lineWidth, dy: lineWidth)).cgPath
        backgroundMask.path = cerclePatch
        
        progressLayer.path = cerclePatch
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color.cgColor
    }
}
