//
//  ShortMeView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct ShortMeView: View {
    @State var URL: String = ""
    @State var serviceEn: String = ""
    
//    @State var
    
   @State var services = [
        Service(title:"is.gd", isChecked: true),
        Service(title:"v.gd", isChecked: false),
        Service(title:"tiny-url", isChecked: false),
        Service(title:"cutt.ly", isChecked: false),
        Service(title:"murl.com", isChecked: false),
        Service(title:"hideurl.com", isChecked: false),
        Service(title:"shrturi.com", isChecked: false),
        Service(title:"shrtco.de", isChecked: false)
    ]
    var body: some View {
        
        VStack {
            VStack {
                Text("Services:")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(5)
                
                List {
                    
                    ForEach(services) { item in
                        HStack {
                            
                            Text(item.title)
                                .font(.title3)
                            Spacer()
                            //checkmark
                            Image(systemName: item.isChecked ?
                                    "checkmark.circle" : "circle")
                                .font(.title2)
                        }
                        
                        .onTapGesture {
                            let index = services.firstIndex(where: { $0.isChecked == true })
                            services[index ?? 0].isChecked = false
                            print(index)
                            let newIndex = services.firstIndex(where: { $0 == item })
                            services[newIndex ?? 0].isChecked = true
                        }
                        .padding()
                        
                    }
                }
                .cornerRadius(15)
                .padding()
                
                Text("URL:")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top)
                
                HStack {
                    
                TextField("Enter your URL here...", text: $URL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing, -5)
                    .padding(.leading)
                    
                    Button(action: {}, label: {
                        Image("icons8-paste")
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding(.trailing)
                    })
                }
                .padding(.top, -5.0)
               
                Button("Go!") {
                    switch services.first(where: { $0.isChecked == true })?.title {
                    case "is.gd":
                        APIRequest.sharedInstance.getIsGd(url: URL) { (history) in
                            
                        }
                    case "v.gd":
                        APIRequest.sharedInstance.getVGd(url: URL) { (history) in
                            
                        }
                    case "tiny-url":
                        APIRequest.sharedInstance.postTinyUrl(url: URL) { (history) in
                            
                        }
                    case "cutt.ly":
                        APIRequest.sharedInstance.getCuttLy(url: URL) { (history) in
                            
                        }
                    case "murl.com":
                        APIRequest.sharedInstance.getMurlCom(url: URL) { (history) in
//                            gotHistory(history)
                        }
                    case "hideurl.com":
                        APIRequest.sharedInstance.postHideuri(url: URL) { (history) in
                            
                        }
                    case "shrturi.com":
                        APIRequest.sharedInstance.postShrturi(url: URL) { (history) in
                            
                        }
                    case "shrtco.de":
                        APIRequest.sharedInstance.getShrtcoDe(url: URL) { (history) in
                            
                        }
                        
                    default:
                        APIRequest.sharedInstance.getIsGd(url: URL) { (history) in
                            
                        }
                    }
                }
                .font(.title2)
                .frame(width: 180, height: 50, alignment: .center)
                .foregroundColor(.pink)
                .background(Color.white)
                .cornerRadius(15)
                .padding()
            }
            
            Spacer()
        }
        
        .background(Image("background").resizable()
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
        
        .onAppear() {
//            APIRequest.sharedInstance.getFromTinyUrl(url: "") { (<#String#>) in
//                <#code#>
//            }

            
            
            
            
            
            let pasteboard = UIPasteboard.general
            
            
            if pasteboard.hasStrings {
//                URL = pasteboard.string ?? ""
                guard let isAuto = UserDefaults.standard.object(forKey: "AutoPaste") else { return }
                
                if isAuto as! String == "On" {
                        print("auto on")
                    URL = "\(pasteboard.string ?? "")"
                }else {
                    print("auto off")
                }
            }
            
            
            
            
            
            func go() {
                for i in 0..<services.count {
                    if services[0].isChecked == true {
                        
                    }
//                    switch services[i].isChecked {
//                    case true:
//                        <#code#>
//                    default:
//                        <#code#>
//                    }
                }
            }
            
            
        }
    }
}

struct ShortMeView_Previews: PreviewProvider {
    static var previews: some View {
        ShortMeView()
    }
}

struct Service: Identifiable, Equatable {
//    static func == (lhs: Service, rhs: Service) -> Bool {
//        return lhs.title == rhs.title && lhs.isChecked == rhs.isChecked
//    }
    var id = UUID()
    
    var title = ""
    var isChecked = false
    
}

func gotHistory(history: History?) {
    
}
