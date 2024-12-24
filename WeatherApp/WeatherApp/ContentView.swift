//
//  ContentView.swift
//  WeatherApp
//
//  Created by Chris on 12/14/24.
//

import SwiftUI

struct ContentView: View {
    
    //Here we are subscribing to the ViewModel so every time data changes, then the data here will be published
    @ObservedObject var viewModel: ViewModel
    
    //These properties will keep track of the state so we can keep track of the animation
    @State var isAnimate = false
    @State var viewState = CGSize.zero
    
    init() {
        viewModel = ViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            
            Spacer()
            Text("Weather")
                .font(.custom("Noteworthy-Bold", size: 40))
                .padding(EdgeInsets(top: 10, leading: 120, bottom: 0, trailing: 120))
            
            //Textfield
            HStack(alignment: .center, spacing: 20) {
                TextField("Enter a city to look up", text: self.$viewModel.cityName) {
                    self.viewModel.cityLookup()
                    self.isAnimate.toggle() //this will make the image to turn back and forth
                }.padding(10)
                    .shadow(color: .blue, radius: 10)
                    .cornerRadius(10)
                    .fixedSize()
                    .font(.custom("Ariel", size: 26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color("background"))
                    .cornerRadius(15)
            }
            //Temperature
            
            HStack(alignment: .center) {
                image(image: "temp", background: "background10") //Check the view created at the end by extracting the subview
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 10, y: 0.0, z: 0.0))
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                
                descriptionText(titleLabel: "Temperature")
                Spacer()
                
                Text(self.viewModel.temperature)
                    .modifier(dataText())
                Spacer()
            }
            
            //Humidity
            HStack(alignment: .center) {
                image(image: "humidity", background: "background6")
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 0.0, y: 10, z: 0.0))
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                
                descriptionText(titleLabel: "Humidity")
                Spacer()
                
                Text(self.viewModel.humid)
                    .modifier(dataText())
                Spacer()
            }
            
            //Pressure
            HStack(alignment: .center) {
                image(image: "pressure", background: "background2")
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 0.0, y: 0.0, z: 10))
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                
                descriptionText(titleLabel: "Pressure")
                Spacer()
                
                Text(self.viewModel.press)
                    .modifier(dataText())
                Spacer()
            }
            
            //Wind speed
            HStack(alignment: .center) {
                image(image: "windSpeed", background: "background4")
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 10, y: 0.0, z: 0.0))
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                
                descriptionText(titleLabel: "Wind Speed")
                Spacer()
                
                Text(self.viewModel.windSpeed)
                    .modifier(dataText())
                Spacer()
            }
            
            //Wind direccion
            HStack(alignment: .center) {
                image(image: "windSpeed", background: "background7")
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 10, y: 0.0, z: 0.0))
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                
                descriptionText(titleLabel: "Wind Direction")
                Spacer()
                
                Text(self.viewModel.windDirection)
                    .modifier(dataText())
                Spacer()
            }
            
            //Cloud percentage
            HStack(alignment: .center) {
                image(image: "cloud", background: "background5")
                
                //Rotation:
                    .rotation3DEffect(Angle(degrees: isAnimate ? 360 : 0), axis: (x: 10, y: 0.0, z: 0.0))
                    .onTapGesture {
                        self.isAnimate.toggle()
                    }
                    .animation(.easeIn(duration: 0.5)) //this is the amount of seconds
                
                descriptionText(titleLabel: "Cloud Percentage")
                Spacer()
                
                Text(self.viewModel.cloudPercent)
                    .modifier(dataText())
                Spacer()
            }
            
            Spacer()
        }
        
        .background(Image("screenBackground")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    //Function to hide the keyboard
    private func hideKeyboard() {
        UIApplication.shared.endEditing(true)
    }
}

#Preview {
    ContentView()
}

//Extracted subviews:
struct image: View {
    
    var image = ""
    var background = ""
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 60)
            .background(Color(background))
            .cornerRadius(20)
            .shadow(radius: 15)
            .padding(.leading, 40)
            .padding(.bottom, 0)
    }
}

struct descriptionText: View {
    var titleLabel = ""
    var body: some View {
        Text(titleLabel)
            .font(.system(size: 18))
            .shadow(color: .black, radius: 0.5, x: 0, y: 1)
            .frame(width: 150, height: 20, alignment: .center)
    }
}

//Modifier for the data received from the API - should be called like: .modifier(dataText())
struct dataText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .shadow(color: .black, radius: 0.5, x: 0, y: 1)
            .fontWeight(.bold)
    }
}

//Extension to hide the keyboard
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
