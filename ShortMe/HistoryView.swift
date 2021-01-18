//
//  HistoryView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct HistoryView: View {
    
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    
    var body: some View {
        
        NavigationView {
            List {
                
                let historyList = UserDefaults.standard.data(forKey:"History")
                
                let historyData = try! JSONDecoder().decode([History].self, from: historyList!)
                
                
                
                ForEach(historyData) { item in
                    
                    
                    VStack {
                        
                        Text("2020/2/2")
                            .font(.body)
                            .foregroundColor(.purple)


                        VStack {
                            Text("Orginal URL: ")
                                .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Text("u")

                            Text("URL")
                                .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                .font(.subheadline)

                            HStack {
                                Spacer()
                                moreButton()
                            }
                            .padding()
                        }

    //                    Divider()
                        Color.pink.frame(height:CGFloat(1) / UIScreen.main.scale)

                        VStack {
                            Text("Short URL:")
                                .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.gray)

                            Text("Short URLShort URLShort URLShort URLShort URLShort URLShort URLShort URLShort URL")
                                .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                                .font(.subheadline)

                            HStack {
                                Spacer()

                                moreButton()
                            }
                            .padding()
                        }


                    }
    //                .overlay(
    //                        RoundedRectangle(cornerRadius: 8)
    //                        .stroke(lineWidth: 1)
    //                    )
                    .padding()

                }
                .onDelete(perform: { indexSet in
    //                self.listItems.remove(atOffsets: indexSet)
                })


                }
//                .cornerRadius(15)
//                .padding(30.0)


                .background(Image("background").resizable()
                                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))

                .navigationBarTitle("History", displayMode: .inline)
                .navigationBarItems(leading: EditButton())
                
//                .navigationBarItems(leading: Button(action: {EditButton()}, label: {
//                    Image(systemName: "trash")
//                }))
        
        }
        
}

}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
struct moreButton: View {

    var body: some View {
        
        Button(action: {}, label: {
            
            Image(systemName: "doc.on.doc")
                .font(.title2)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.white)
                .background(Image("background").resizable())
                .clipShape(Circle())
                .overlay(Circle().stroke())
                
                
        })
        .padding()
        Button(action: {}, label: {
            Image(systemName: "safari")
                .font(.title)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.white)
                .background(Image("background").resizable())
                .clipShape(Circle())
                .overlay(Circle().stroke())
        })
        .padding()
        
        
        
        
        
        
        
//        HStack {
//            VStack {
//                Text("Url")
//                    .font(.title)
//                    .padding(.bottom, -2.0)
//
//
//                Text("Long url")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//            }
//
//            Spacer()
//            VStack {
//                Text("Date")
//                    .font(.title3)
//                    .foregroundColor(.purple)
//
//                Image("icons8-globe")
//                    .foregroundColor(.blue)
//
//            }
//
//
//
//        }
        .listRowBackground(Color.clear)
    }
}
//ScrollView {
//    VStack(alignment: .leading) {
//        ForEach(1...10) { _ in
//            CustomRow()
//        }
//    }
//}
