//
//  HistoryView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct HistoryView: View {
    
    @State var showRemoveAllAlert: Bool = false
    @State var showRemoveAllButton: Bool = false
    @State var showDeleteButton: Bool = false
    @State private var showToast: Bool = false
    
    @State var sortByLast = UserDefaults.standard.bool(forKey: "SortHistory")
    
    @State private var historyData : [History] = []
    
    @State private var historyDefault = UserDefaults.standard.data(forKey: "History")
    
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        
        if historyDefault == nil || historyDefault?.count == 2 {
            NavigationView {
                VStack {
                    Image(systemName: "folder.circle").resizable()
                        .frame(width: 70, height: 70, alignment: .center)
                    Text("History is Empty")
                        .font(.title2)
                }
                .foregroundColor(.purple)
                .padding()
                
                .navigationBarTitle("History", displayMode: .inline)
                
                .onAppear(perform: {
                    
                    if (UserDefaults.standard.data(forKey: "History") != nil) {
                        historyDefault = UserDefaults.standard.data(forKey: "History")
                    }
                })
            }
            
        } else {
            
            NavigationView {
                
                ScrollView {
                    
                    ForEach(historyData) { item in
                        
                        VStack {
                            
                            Text(item.date)
                                .font(.body)
                                .foregroundColor(.purple)
                            
                            HStack {
                                VStack {
                                    Text("Orginal URL: ")
                                        .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                        .font(.body)
                                        .foregroundColor(Color("gray&white"))
                                    
                                    
                                    
                                    Text(item.orginalURL)
                                        .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                        .font(.subheadline)
                                        .padding(2)
                                    
                                    
                                }
                                .padding(.bottom, 5)
                                Spacer()
                                moreButton(insURL: item.orginalURL)
                            }
                            
                            // divider
                            Color.pink.frame(height:CGFloat(1) / UIScreen.main.scale)
                            
                            HStack {
                                VStack {
                                    Text("Short URL:")
                                        .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                        .font(.body)
                                        .foregroundColor(Color("gray&white"))
                                    
                                    Text(item.shortURL)
                                        .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                        .font(.subheadline)
                                    
                                }
                                Spacer()
                                moreButton(insURL: item.shortURL)
                            }
                            if showDeleteButton {
                                
                                Color.pink.frame(height:CGFloat(1) / UIScreen.main.scale)
                                
                                Button(action: {
                                    historyData.removeAll(where: {$0.shortURL == item.shortURL})
                                    if let encoder = try? JSONEncoder().encode(historyData) {
                                        print(encoder)
                                        UserDefaults.standard.set(encoder, forKey: "History")
                                    }
                                    
                                    if historyData.count == 0 {
                                        historyDefault = nil
                                    }
                                    
                                    UserDefaults.standard.synchronize()
                                    
                                },label: {
                                    
                                    Text("Delete")
                                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, maxHeight: 40, alignment: .center)
                                })
                                .foregroundColor(.white)
                                .background(RoundedCorners(color: .red, tl: 0, tr: 0, bl: 30, br: 30))
                            }
                        }
                        .padding()
                        .background(Color("white&gray"))
                        .cornerRadius(20.0)
                        .padding(.top, 5)
                        .padding(.leading)
                        .padding(.trailing)
                    }
                    .onAppear() {
                        historyData.sort { (lhs, rhs) -> Bool in
                            return lhs.timeStamp > rhs.timeStamp
                        }
                    }
                }
                .navigationBarTitle("History", displayMode: .inline)
                .navigationBarItems(leading:
                                        
                                        Button(action: {
                                            if showRemoveAllButton {
                                                showRemoveAllAlert = true
                                            }
                                            showRemoveAllButton = true
                                            showDeleteButton = true
                                        }, label: {
                                            if showRemoveAllButton {
                                                Text("All")
                                            }else {
                                                Image(systemName: "trash")
                                            }
                                        })
                                    , trailing:
                                        Button(action: {
                                            
                                            if sortByLast {
                                                historyData.sort { (lhs, rhs) -> Bool in
                                                    return lhs.timeStamp < rhs.timeStamp
                                                }
                                                sortByLast = false
                                                UserDefaults.standard.setValue(false, forKey: "SortHistory")
                                            }else {
                                                historyData.sort { (lhs, rhs) -> Bool in
                                                    return lhs.timeStamp > rhs.timeStamp
                                                }
                                                sortByLast = true
                                                UserDefaults.standard.setValue(true, forKey: "SortHistory")
                                            }
                                            
                                        }, label: {
                                            if showRemoveAllButton {
                                                Button("Done") {
                                                    print("Done tapped!")
                                                    showRemoveAllButton = false
                                                    showDeleteButton = false
                                                }
                                            }else {
                                                if sortByLast {
                                                    Image(systemName: "chevron.up.circle")
                                                }else {
                                                    Image(systemName: "chevron.down.circle")
                                                }
                                            }
                                        })
                )
                .foregroundColor(.purple)
                .alert(isPresented: $showRemoveAllAlert, content: {
                    Alert(title: Text("Remove All"), message: Text("Do you want to remove all?"), primaryButton: .destructive(Text("Delete")){
                        
                        historyDefault = nil
                        historyData.removeAll()
                        
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                        UserDefaults.standard.synchronize()
                        
                    }, secondaryButton: .cancel())
                })
                
                .background(Image("background").resizable()
                                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
            }
            .onAppear(perform: {
                self.reload()
                
                if sortByLast {
                    historyData.sort { (lhs, rhs) -> Bool in
                        return lhs.timeStamp > rhs.timeStamp
                    }
                }else {
                    historyData.sort { (lhs, rhs) -> Bool in
                        return lhs.timeStamp < rhs.timeStamp
                    }
                }
            })
            .onDisappear(perform: {
                showRemoveAllButton = false
                showDeleteButton = false
            })
            
        }
        
    }
    private func reload() {
        historyData = try! JSONDecoder().decode([History].self, from: UserDefaults.standard.data(forKey: "History")!)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
struct moreButton: View {
    
    let pasteboard = UIPasteboard.general
    
    var insURL: String
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        Button(action: {
            pasteboard.string = insURL
        }, label: {
            Image(systemName: "doc.on.doc")
                .font(.title2)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.white)
                .background(Image("background").resizable())
                .clipShape(Circle())
                .overlay(Circle().stroke().foregroundColor(.purple))
        })
        .padding(.trailing)
        Button(action: {
            openURL(URL(string: insURL)!)
        }, label: {
            Image(systemName: "safari")
                .font(.title)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.white)
                .background(Image("background").resizable())
                .clipShape(Circle())
                .overlay(Circle().stroke().foregroundColor(.purple))
        })
        .padding(.trailing, 5)
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}
