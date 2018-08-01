//
//  LueQRCodeConstroller.swift
//
//  Created by Luiz on 2018/8/1.
//  Copyright © 2018年 lue. All rights reserved.
//

import UIKit

class LueQRCodeConstroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class LueScanAnimationView: UIView {
    convenience init(frame: CGRect, c lineColor: UIColor) {
        self.init(frame: frame)
        self.lineColor = lineColor
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var lineColor: UIColor!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCorner()
    }
    private func drawCorner() {
        let w = frame.width
        let h = frame.height
        let l: CGFloat = 20 // lineLength
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(3.6)
        
        // left up
        draw(context, [(0, 0), (l, 0), (0, l)])
        // right up
        draw(context, [(w, 0), (w, l), (w - l, 0)])
        // right down
        draw(context, [(w, h), (w - l, h), (w, h - l)])
        // left down
        draw(context, [(0, h), (0, h - l), (l, h)])
    }
    private func draw(_ context: CGContext?, _ points: [(x: CGFloat, y: CGFloat)]) {
        var ps = points
        guard let move = ps.popLast() else {
            return
        }
        let path = CGMutablePath()
        path.move(to: CGPoint(x: move.x, y: move.y))
        
        ps.forEach { (p) in
            path.addLine(to: CGPoint(x: p.x, y: p.y))
        }
        context?.addPath(path)
        context?.strokePath()
    }
}
