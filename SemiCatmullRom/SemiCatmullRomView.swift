//
//	BezierView.swift
//	BezierTest2
//
//	Created by Kaz Yoshikawa on 4/25/20.
//	Copyright © 2020 Kaz Yoshikawa. All rights reserved.
//

import UIKit


infix operator %%

fileprivate extension Int {

	static func %% (lhs: Int, rhs: Int) -> Int {
		let rem = lhs % rhs // -rhs <= rem <= rhs
		return rem >= 0 ? rem : rem + rhs
	}

}

fileprivate extension Array {

	subscript(circular index: Int) -> Element {
		get {
			assert(self.count > 0)
			return self[self.circularIndex(index)]
		}
		set {
			assert(self.count > 0)
			return self[self.circularIndex(index)] = newValue
		}
	}

	func circularIndex(_ index: Int) -> Int {
		assert(self.count > 0)
		return index %% self.count
	}

}

extension UIBezierPath {

	convenience init(semiCatmullRom: [CGPoint], close: Bool, K: CGFloat = 0.2) {
		self.init()
		let points = semiCatmullRom
		var c1 = [Int: CGPoint]()
		var c2 = [Int: CGPoint]()
		let count = close ? points.count + 1 : points.count - 1
		for index in 1 ..< count {
			let p = points[circular: index]
			let v = (points[circular: index + 1] - points[index - 1]) * K
			c2[(index + points.count - 1) % points.count] = (p - v)
			c1[(index + points.count) % points.count] = (p + v)
		}
		self.move(to: points[0])
		for index in 0 ..< (close ? points.count : points.count - 1) {
			let c1 = c1[index] ?? points[points.circularIndex(index)]
			let c2 = c2[index] ?? points[points.circularIndex(index + 1)]
			self.addCurve(to: points[circular: index  + 1], controlPoint1: c1, controlPoint2: c2)
		}
	}

}


class SemiCatmullRomView: UIView {

	func plot(point: CGPoint, color: UIColor) {
		color.set()
		let x = CGFloat(point.x)
		let y = CGFloat(point.y)
		UIBezierPath(ovalIn: CGRect(x: x-3, y: y-3, width: 7, height: 7)).fill()
	}
	
	func line(_ p0: CGPoint, _ p1: CGPoint, color: UIColor) {
		color.set()
		let bezier = UIBezierPath()
		bezier.move(to: p0)
		bezier.addLine(to: p1)
		bezier.stroke()
	}

	var points: [CGPoint] = [
		CGPoint(x: 100, y: 100),
		CGPoint(x: 200, y: 450),
		CGPoint(x: 400, y: 600),
		CGPoint(x: 350, y: 350),
		CGPoint(x: 600, y: 300),
		CGPoint(x: 500, y: 200),
	] {
		didSet {
			self.setNeedsDisplay()
		}
	}

	var close = true {
		didSet {
			print(Self.self)
			self.setNeedsDisplay()
		}
	}

	private (set) lazy var setup: (()->()) = {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Self.tapGesture(_:)))
		self.addGestureRecognizer(tapGesture)
		return {}
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		self.setup()
		self.setNeedsDisplay()
	}

	@objc func tapGesture(_ sender: UIGestureRecognizer) {
		self.points.append(sender.location(in: self))
		print(sender.location(in: self))
	}
	
	override func draw(_ rect: CGRect) {

		if self.points.count > 1 {
			UIColor.orange.withAlphaComponent(0.5).set()
			let bezier = UIBezierPath(semiCatmullRom: self.points, close: self.close)
			bezier.lineWidth = 8
			bezier.stroke()
		}
	
		self.points.forEach { self.plot(point: $0, color: UIColor.black) }
		for (p1, p2) in zip(self.points.dropLast(), self.points.dropFirst()) {
			self.line(p1, p2, color: UIColor.lightGray)
		}
	}
	
	func clear() {
		self.points = []
	}

}
