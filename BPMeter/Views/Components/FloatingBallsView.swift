import SwiftUI
import SpriteKit

struct FloatingBallsView: View {
    @State var viewModel: FloatingBallsViewModel

    var body: some View {
        GeometryReader { geometry in
            SpriteView(scene: createScene(size: geometry.size), options: [.allowsTransparency])
                .ignoresSafeArea()
                .background(Color.clear)
        }
    }

    func createScene(size: CGSize) -> SKScene {
        let scene = BallScene()
        scene.size = size
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        viewModel.scene = scene
        return scene
    }
}

class BallScene: SKScene {
    override func didMove(to view: SKView) {
        // Set up physics world without gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Create edge boundaries
        let boundary = SKPhysicsBody(edgeLoopFrom: frame)
        boundary.friction = 0
        boundary.restitution = 1.0
        physicsBody = boundary

        // Create random number of balls (2-4)
        let ballCount = Int.random(in: 2...4)

        for _ in 0..<ballCount {
            createBall()
        }
    }

    func createBall() {
        let radius = CGFloat.random(in: 70...110)
        let ball = SKShapeNode(circleOfRadius: radius)

        // Random position, ensuring ball is fully within bounds
        let x = CGFloat.random(in: radius...(size.width - radius))
        let y = CGFloat.random(in: radius...(size.height - radius))
        ball.position = CGPoint(x: x, y: y)

        // White fill
        ball.fillColor = .lightGray
        ball.strokeColor = .lightGray
        ball.lineWidth = 2

        // Physics body
        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.angularDamping = 0.5
        ball.physicsBody?.allowsRotation = true

        // Give initial random velocity
        let velocityX = CGFloat.random(in: -50...50)
        let velocityY = CGFloat.random(in: -50...50)
        ball.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)

        addChild(ball)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        applyForceFromTap(at: location)
    }

    // Public method to handle external taps
    func handleExternalTap(at location: CGPoint) {
        applyForceFromTap(at: location)
    }

    private func applyForceFromTap(at location: CGPoint) {
        // Apply force to all balls based on distance from tap
        enumerateChildNodes(withName: "*") { node, _ in
            if let ball = node as? SKShapeNode, let physicsBody = ball.physicsBody {
                // Calculate direction from touch to ball center
                let dx = ball.position.x - location.x
                let dy = ball.position.y - location.y
                let distance = sqrt(dx * dx + dy * dy)

                if distance > 0 {
                    // Normalize direction
                    let dirX = dx / distance
                    let dirY = dy / distance

                    // Force decreases with distance (inverse square-ish falloff)
                    let maxDistance: CGFloat = 500
                    let distanceFactor = max(0, 1 - (distance / maxDistance))
                    let forceMagnitude = physicsBody.mass * 400 * distanceFactor

                    let impulse = CGVector(dx: dirX * forceMagnitude, dy: dirY * forceMagnitude)

                    // Apply impulse
                    physicsBody.applyImpulse(impulse)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()

        FloatingBallsView(viewModel: .init())
    }
}
