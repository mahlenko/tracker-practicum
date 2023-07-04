//
// Created by Сергей Махленко on 03.07.2023.
//

import UIKit

extension CALayer {
    func borderGradient(colors: [CGColor], start: CGPoint = .topLeft, end: CGPoint = .topRight) {
        let identified = "borderGradient"
        let beforeGradientLayer = sublayers?.first { layer in
            layer.accessibilityLabel == identified
        }

        if beforeGradientLayer != nil { return }

        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.colors = colors
        gradient.accessibilityLabel = identified

        let shape = CAShapeLayer()
        let pathFrame = CGRect(
            x: gradient.bounds.minX + (borderWidth / 2),
            y: gradient.bounds.minY + (borderWidth / 2),
            width: gradient.bounds.width - borderWidth,
            height: gradient.bounds.height - borderWidth
        )

        shape.fillColor = .none
        shape.strokeColor = UIColor.asset(.black).cgColor
        shape.lineWidth = borderWidth
        shape.path = UIBezierPath(
            roundedRect: pathFrame,
            cornerRadius: cornerRadius + (borderWidth * 2)
        ).cgPath

        gradient.mask = shape

        // hide border, important alpha 0
        borderColor = CGColor.init(gray: 1, alpha: 0)

        insertSublayer(gradient, at: 0)
    }
}
