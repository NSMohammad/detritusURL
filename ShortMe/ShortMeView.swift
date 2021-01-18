//
//  ShortMeView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct ShortMeView: View {
    @State var orginalURL: String = ""
    @State var shortURL: String = ""
    @State var progressLoading: Bool = false
    
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
    
    
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    
    var body: some View {
        
        NavigationView {
        VStack {
            VStack {
                Text("Services:")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.bottom , -15)
                
                ScrollView(showsIndicators: false) {
                    
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
                            
                            let newIndex = services.firstIndex(where: { $0 == item })
                            services[newIndex ?? 0].isChecked = true
                            
                            withAnimation {
                                self.progressLoading = false
                            }
                            
                        }
                        
                        .padding(.leading)
                        .padding(.trailing)
                        Color.pink.frame(height:CGFloat(2) / UIScreen.main.scale)
                        
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding()
                
                    
                
                Text("URL:")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.bottom, -10)
                
                HStack {
                    
                TextField("Enter your URL here...", text: $orginalURL, onCommit: {
                    changeURL()
                  })
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
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding(.trailing)
                    })
                }
                
                if progressLoading {
                    ProgressView()
                        .frame(width: 60, height: 40, alignment: .center)
                        
                }
                
                
                if shortURL != "" {
                    withAnimation {
                        VStack {
                            Text("Short URL:")
                                .font(.title3)
                            
                            HStack {
                                Text(shortURL)
                                    .font(.title2)
                                    .padding(.leading, 25)
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    pasteboard.string = "\(shortURL)"
                                    
                                }, label: {
                                    Image(systemName: "doc.on.doc")
                                    
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
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                    .padding(.trailing)
                        )
                        }
                        .foregroundColor(.white)
                        
                    }
                    
                }else {
                    
                }
                
                
                
                
                
                Button("Go!") {
                    changeURL()
            }.font(.title2)
                .frame(width: 180, height: 50, alignment: .center)
                .foregroundColor(.pink)
                .background(Color.white)
                .cornerRadius(15)
                .padding()
            }
            
            Spacer()
        }
        
        .background(Image("background").resizable()
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
        
        .onAppear() {
            
            
            if pasteboard.hasStrings {
//                URL = pasteboard.string ?? ""
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
    }
        
    }
    func gotHistory(history: History?) {
        guard let historyItem = history else { return }
        print(historyItem)
        var historyList: [History]

        let historyListData =  UserDefaults.standard.data(forKey: "History")
        if historyListData == nil {
            historyList = [History]()
        }else {
            historyList = try! JSONDecoder().decode([History].self, from: historyListData!)
        }
        
        historyList.append(historyItem)
        
        print(historyList)
        if let encoder = try? JSONEncoder().encode(historyList) {
            UserDefaults.standard.set(encoder, forKey: "History")
            
            print(historyList)
        }
////        print(UserDefaults.standard.object(forKey: "History")!)
//        if let loadedTemp = try? JSONDecoder().decode([History].self, from: historyList!) {
//
//        }
        
        
//        historyList?.removeFirst(<#T##k: Int##Int#>)

        if history?.shortURL != nil {
            shortURL = history?.shortURL ?? ""
        }
        withAnimation {
            progressLoading.toggle()
        }
        
        
    }
    
    func changeURL() {
        if self.progressLoading == false {
        if orginalURL != "" {
        withAnimation {
            self.progressLoading.toggle()
            shortURL = ""
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


// app mire back ground bar migarde auto paste beshe

