//
//  ContentView.swift
//  InstafilterReal
//
//  Created by Can Önal on 30.09.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 40.0
    @State private var filterScale = 5.0
    @State private var filterAngle = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    //It's a good idea to create a CIContext once and re-use it for performance
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap the select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                SliderView(
                    filterIntensity: $filterIntensity,
                    filterRadius: $filterRadius,
                    filterAngle: $filterAngle,
                    filterScale: $filterScale,
                    onChange: { applyProcessing() }
                )
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled((image == nil) ? true : false)
                        .alert("Photo is saved!", isPresented: $showingAlert) {
                            Button("OK") {}
                        }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                //https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Gloom") { setFilter(CIFilter.gloom()) }
                    Button("Hue Adjust") { setFilter(CIFilter.hueAdjust()) }
                    Button("Instant") { setFilter(CIFilter.photoEffectInstant()) }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
            showingAlert = true
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputAngleKey) {
            currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // first we convert CGImage to UIImage, then to Image
            // beacuse our ImageSaver expects a UIImage. But you can
            // go from CIImage to Image directly.
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct SliderView: View {
    @Binding var filterIntensity: Double
    @Binding var filterRadius: Double
    @Binding var filterAngle: Double
    @Binding var filterScale: Double
    
    let onChange: () -> Void
    
    var body: some View {
        HStack {
            Text("Intensity")
            Slider(value: $filterIntensity, in: 0...1)
                .onChange(of: filterIntensity) { _ in onChange()}
        }
        .padding(.top)

        HStack {
            Text("Radius")
            Slider(value: $filterRadius, in: 0...80)
                .onChange(of: filterRadius) { _ in onChange()}
        }
    
        HStack {
            Text("Angle")
            Slider(value: $filterAngle, in: 0...1)
                .onChange(of: filterAngle) { _ in onChange()}
        }
        
        HStack {
            Text("Scale")
            Slider(value: $filterScale, in: 0...50)
                .onChange(of: filterScale) { _ in onChange()}
        }
        .padding(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
