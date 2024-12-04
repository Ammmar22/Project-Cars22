import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool
    @Binding var imageURL: URL? // Add this binding to capture the URL

    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?
        @Binding var isImagePickerPresented: Bool
        @Binding var imageURL: URL? // Add this to capture the image URL

        init(image: Binding<UIImage?>, isImagePickerPresented: Binding<Bool>, imageURL: Binding<URL?>) {
            _image = image
            _isImagePickerPresented = isImagePickerPresented
            _imageURL = imageURL // Initialize the URL binding

        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                image = selectedImage
            }
            if let url = info[.imageURL] as? URL {
                            imageURL = url // Capture the image URL
                        }
            isImagePickerPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isImagePickerPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isImagePickerPresented: $isImagePickerPresented, imageURL: $imageURL)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
