//
//  InfoView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct InfoView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    @State private var autoPaste: Bool = false
    
    
    
    var body: some View {
        
        
        
        NavigationView {
        VStack {
            Image("roundedPNG")
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .padding()
            
            
            Text("App Version: \(appVersion)")
                .foregroundColor(.white)
                .padding(.top, -10)
                .padding(.bottom, 30)
            
            Toggle(isOn: $autoPaste, label: {
                Text("Auto paste URL")
                    .font(.title3)
                    .foregroundColor(.white)
            })
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundColor(autoPaste ? .white : .black)
            )
            .toggleStyle(PowerToggleStyle())
            .foregroundColor(.white)
            .padding()
            .onChange(of: autoPaste, perform: { value in
                switch value {
                case true:
                    UserDefaults.standard.setValue("On", forKey: "AutoPaste")
                case false:
                    UserDefaults.standard.setValue("Off", forKey: "AutoPaste")
                }
                
            })
            
            Text("Your last selected website will used on today extension (widget) default website")
                .font(.footnote)
                .foregroundColor(.white)
                
                .padding()
            
            Spacer()
            
        }
        .padding(50)
        .background(Image("background").resizable()
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
        .onAppear() {
            guard let isAuto = UserDefaults.standard.object(forKey: "AutoPaste") else { return }
            
            if isAuto as! String == "On" {
                print("auto on")
                autoPaste = true
            }else {
                print("auto off")
                autoPaste = false
            }
        }
        
        .navigationBarTitle("Info", displayMode: .inline)
    }
    }
    
    func autoPasteChecked() {
        
    }
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct PowerToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .white : .black)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.purple)
                        .padding(.all, 3)
                        .overlay(
                            GeometryReader { geo in
                                Path { p in
                                    if !configuration.isOn {
                                        p.addRoundedRect(in: CGRect(x: 20, y: 10, width: 10.5, height: 10.5), cornerSize: CGSize(width: 7.5, height: 7.5), style: .circular, transform: .identity)
                                    } else {
                                        p.move(to: CGPoint(x: 51/2, y: 10))
                                        p.addLine(to: CGPoint(x: 51/2, y: 31-10))
                                    }
                                }.stroke(configuration.isOn ? Color.white : Color.black, lineWidth: 2)
                            }
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                    
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
