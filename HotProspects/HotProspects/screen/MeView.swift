//
//  MeView.swift
//  HotProspects
//
//  Created by Can Önal on 27.10.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrcode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                Form {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title2)
                    
                    TextField("Email Address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title2)
                }
                Image(uiImage: qrcode)
                    .resizable()
                    .interpolation(.none) // -> otherwise image is blurry
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrcode)
                        } label: {
                            Label("Save to photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your QR Code")
            .onAppear(perform: updateQRCode)
            .onChange(of: name) { _ in updateQRCode() }
            .onChange(of: emailAddress) { _ in updateQRCode() }
        }
    }
    
    func updateQRCode() {
        qrcode = generateQqCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQqCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
