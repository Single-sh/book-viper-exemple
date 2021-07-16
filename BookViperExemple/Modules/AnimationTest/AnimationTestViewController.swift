import UIKit

class AnimationTestViewController: UIViewController {
    @IBOutlet private var cubeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation(cut: .leftBottom)
    }
    
    private func animation(cut: Cut) {
        UIView.animate(withDuration: 1, delay: 1, options: .curveLinear) {
            self.cubeView.transform = .init(translationX: cut.x, y: cut.y)
                .scaledBy(x: cut.scale, y: cut.scale)
                .rotated(by: cut.rotate * -1)
        } completion: { result in
            self.animation(cut: cut.next)
        }
    }

}

enum Cut {
    case leftTop
    case rightTop
    case leftBottom
    case rightBottom
    
    var x: CGFloat {
        switch self {
        case .leftBottom, .leftTop:
            return -50
        default:
            return 50
        }
    }
    
    var y: CGFloat {
        switch self {
        case .leftTop, .rightTop:
            return -50
        default:
            return 50
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .leftTop, .rightBottom:
            return 1
        default:
            return 0.5
        }
    }
    
    var rotate: CGFloat {
        switch self {
        case .leftBottom:
            return  (.pi / 2)
        case .leftTop:
            return .pi
        case .rightTop:
            return (.pi / 2 + .pi)
        case .rightBottom:
            return (.pi * 2)
        }
    }
    
    var next: Cut {
        switch self {
        case .leftBottom:
            return .leftTop
        case .leftTop:
            return .rightTop
        case .rightTop:
            return .rightBottom
        case .rightBottom:
            return .leftBottom
        }
    }
}
