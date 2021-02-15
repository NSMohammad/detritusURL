//
//  ShortMeView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI
import SystemConfiguration

struct ShortMeView: View {
    
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    @State var alertForConnection = false
    
    @State var orginalURL: String = ""
    @State var shortURL: String = ""
    @State var progressLoading: Bool = false
    
    @State var keepOrgURL: String = ""
    
    @State var historyModel : History?
    
    @Environment(\.openURL) var openURL
    
    let pasteboard = UIPasteboard.general
    
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
    
    @State var showsAlert = false
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("Services:")
                        .font(.title3)
                        .foregroundColor(Color("white&black"))
                        .padding(.top)
                        .padding(.bottom , -15)
                    
                    ScrollView(showsIndicators: false) {
                        
                        ForEach(services) { item in
                            
                            HStack {
                                
                                Text(item.title)
                                    .font(.title3)
                                    .foregroundColor(Color("black&white"))
                                
                                Spacer()
                                
                                Image(systemName: item.isChecked ?
                                        "checkmark.circle" : "circle")
                                    .font(.title2)
                                    .foregroundColor(Color("black&white"))
                                
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                let index = services.firstIndex(where: { $0.isChecked == true })
                                services[index!].isChecked = false
                                
                                let newIndex = services.firstIndex(where: { $0 == item })
                                services[(newIndex ?? index)!].isChecked = true
                                
                                if services[(newIndex ?? index)!].isChecked == true {
                                    keepOrgURL = ""
                                }
                                
                                withAnimation(.linear(duration: 1)) {
                                    self.progressLoading = false
                                }
                                
                            }
                            
                            .padding(.leading)
                            .padding(.trailing)
                            Color.pink.frame(height:CGFloat(1.0) / UIScreen.main.scale)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 370, alignment: .center)
                    .padding()
                    .background(Color("white&black"))
                    .cornerRadius(15)
                    .padding()
                    
                    Text("URL:")
                        .font(.title3)
                        .foregroundColor(Color("white&black"))
                        .padding(.bottom, -10)
                    
                    HStack {
                        
                        TextField("Enter your URL here...", text: $orginalURL, onCommit: {
                            changeURL()
                        })
                        .foregroundColor(Color("gray&white"))
                        .textContentType(.URL)
                        .keyboardType(.URL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing, -5)
                        .padding(.leading)
                        
                        
                        Button(action: {
                            
                            if pasteboard.hasStrings {
                                orginalURL = pasteboard.string ?? ""
                            }
                        }, label: {
                            Image("icons8-paste")
                                .foregroundColor(Color("white&black"))
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(.trailing)
                        })
                    }
                    
                    if orginalURL != "" {
                        ZStack {
                            if progressLoading {
                                
                                ProgressView()
                                    .frame(width: 60, height: 40, alignment: .center)
                                
                            }
                            if shortURL != "" {
                                
                                VStack {
                                    
                                    Text("Short URL:")
                                        .font(.title3)
                                    
                                    HStack {
                                        Text(shortURL)
                                            .font(.title2)
                                            .padding(.leading, 25)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            withAnimation {
                                                pasteboard.string = shortURL
                                            }
                                        }, label: {
                                            Image(systemName: "doc.on.doc")
                                                .transition(.slide)
                                            
                                        })
                                        .padding(5)
                                        Button(action: {
                                            
                                            openURL(URL(string: shortURL)! )
                                            
                                        }, label: {
                                            Image(systemName: "safari")
                                        })
                                        .padding(.trailing, 20)
                                        .padding(5)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                    
                                    .padding(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke()
                                            .stroke(lineWidth: 1.5)
                                            .foregroundColor(Color("white&black"))
                                            .padding(.leading)
                                            .padding(.trailing)
                                    )
                                }
                                .foregroundColor(Color("white&black"))
                            }
                        }
                    }
                    
                    Button(action: {
                        var flags = SCNetworkReachabilityFlags()
                        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
                        
                        if self.isNetworkReachable(with: flags) {
                            if keepOrgURL != orginalURL {
                                changeURL()
                            }
                        }else {
                            alertForConnection = true
                        }
                        
                    }, label: {
                        Text("Go!")
                            .frame(minWidth: 100, maxWidth: 180, minHeight: 50, maxHeight: 50, alignment: .center)
                            .font(.title2)
                            .foregroundColor(.pink)
                            .background(Color("white&black"))
                            .cornerRadius(15)
                            .padding()
                    })
                    
                    
                }
                
                Spacer()
            }
            
            .background(Image("background").resizable()
                            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
            
            .onAppear() {
                
                
                if pasteboard.hasStrings {
                    guard let isAuto = UserDefaults.standard.object(forKey: "AutoPaste") else { return }
                    
                    if isAuto as! String == "On" {
                        print("auto on")
                        orginalURL = "\(pasteboard.string ?? "")"
                    }else {
                        print("auto off")
                    }
                }
            }
            .navigationBarTitle("Short me", displayMode: .inline)
            .alert(isPresented: $showsAlert) {
                Alert(title: Text("Cant use of this service"), message: Text("Try another service Or check URL"), dismissButton: .default(Text("Got it!")))
            }
        }
        .alert(isPresented: $alertForConnection, content: {
            Alert(title: Text("Network Lost"), message: Text("Check Your Connection"), dismissButton: .default(Text("OK")))
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    
    func changeURL() {
        if self.progressLoading == false {
            if orginalURL != "" {
                withAnimation {
                    self.progressLoading.toggle()
                    shortURL = ""
                }
                if orginalURL.contains("://") == false {
                    orginalURL = "Https://" + orginalURL
                }
                switch services.first(where: { $0.isChecked == true })?.title {
                case "is.gd":
                    APIRequest.sharedInstance.getIsGd(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "v.gd":
                    APIRequest.sharedInstance.getVGd(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "tiny-url":
                    APIRequest.sharedInstance.postTinyUrl(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "cutt.ly":
                    APIRequest.sharedInstance.getCuttLy(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "murl.com":
                    APIRequest.sharedInstance.getMurlCom(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "hideurl.com":
                    APIRequest.sharedInstance.postHideuri(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "shrturi.com":
                    APIRequest.sharedInstance.postShrturi(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                case "shrtco.de":
                    APIRequest.sharedInstance.getShrtcoDe(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                    
                default:
                    APIRequest.sharedInstance.getIsGd(url: orginalURL) { (history) in
                        gotHistory(history: history)
                    }
                }
            }
        }
    }
    
    func gotHistory(history: History?) {
        guard let historyItem = history else {
            showsAlert = true
            withAnimation(.easeInOut(duration: 0.5)) {
                progressLoading.toggle()
            }
            return
        }
        print(historyItem)
        var historyList: [History]
        
        let historyListData =  UserDefaults.standard.data(forKey: "History")
        if historyListData == nil {
            historyList = [History]()
        }else {
            historyList = try! JSONDecoder().decode([History].self, from: historyListData!)
        }
        
        historyList.append(historyItem)
        
        if historyList.count >= 500 {
            historyList.removeFirst()
        }
        
        print(historyList)
        if let encoder = try? JSONEncoder().encode(historyList) {
            UserDefaults.standard.set(encoder, forKey: "History")
            
            print(historyList)
        }
        
        
        
        UserDefaults.standard.set(true, forKey: "SortHistory")
        
        if history?.shortURL != nil {
            shortURL = history?.shortURL ?? ""
        }
        progressLoading.toggle()
        
        keepOrgURL = orginalURL
        
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let connectionWithoutInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needConnection || connectionWithoutInteraction)
    }
    
}

struct ShortMeView_Previews: PreviewProvider {
    static var previews: some View {
        ShortMeView()
    }
}

struct Service: Identifiable, Equatable {
    var id = UUID()
    
    var title = ""
    var isChecked = false
    
}

