import RealityKit
import SwiftUI

struct Model3DView: UIViewRepresentable {
    let modelName: String

    func makeUIView(context: Context) -> ARView {
        print("Attempting to load the 3D model from name: \(modelName)")

        let arView = ARView(frame: .zero)
        arView.automaticallyConfigureSession = true

        // Add default lighting
        arView.environment.lighting.resource = try? EnvironmentResource.load(named: "default")

        // Try to load the 3D model from the app's bundle
        if let modelURL = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
            do {
                let modelEntity = try ModelEntity.loadModel(contentsOf: modelURL)
                modelEntity.setScale(SIMD3<Float>(0.01, 0.01, 0.01), relativeTo: nil)
                modelEntity.setPosition(SIMD3<Float>(0, 0, -0.5), relativeTo: nil)

                let anchor = AnchorEntity()
                anchor.addChild(modelEntity)
                arView.scene.addAnchor(anchor)
                print("Model loaded and added to the scene.")
            } catch {
                print("Error loading model: \(error.localizedDescription)")
            }
        } else {
            print("Model file not found.")
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
