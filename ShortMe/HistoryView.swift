//
//  HistoryView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI
import FontAwesome_swift

struct HistoryView: View {
    var body: some View {
        
        List {
            ForEach(0...5, id: \.self) { item in
                
                
                VStack {
                    
                    Text("2020/2/2")
                        .font(.body)
                        .foregroundColor(.purple)
                    
                    
                    VStack {
                        Text("Orginal URL:")
                            .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Text("URL")
                            .frame(maxWidth: .infinity, minHeight: 0, alignment: .leading)
                            .font(.subheadline)
                            
                        HStack {
                            Spacer()
                            Button(action: {}, label: {
                                Image(systemName: "doc.on.doc")
                            })
                            .padding()
                            Button(action: {}, label: {
                                Image(systemName: "safari")
                            })
                            .padding()
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
                                
                            Button(action: {}, label: {
                                Image(systemName: "doc.on.doc")
                            })
                            .padding()
                            Button(action: {}, label: {
                                Image(systemName: "safari")
                            })
                            .padding()
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
//            .cornerRadius(30)
            
        }
//        .listStyle(SidebarListStyle())
        
        .cornerRadius(15)
        .padding(30.0)
        
        
        .background(Image("background").resizable()
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: .infinity, maxHeight: .infinity, alignment: .center))
        
        }
//    .navigationBarTitle("History", displayMode: .inline)
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
struct TestRow: View {

    var body: some View {
        HStack {
            VStack {
                Text("Url")
                    .font(.title)
                    .padding(.bottom, -2.0)
                    

                Text("Long url")
                    .font(.title3)
                    .foregroundColor(.gray)
            }

            Spacer()
            VStack {
                Text("Date")
                    .font(.title3)
                    .foregroundColor(.purple)

                Image("icons8-globe")
                    .foregroundColor(.blue)

            }



        }
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
