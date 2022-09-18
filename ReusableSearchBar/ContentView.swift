//
//  ContentView.swift
//  ReusableSearchBar
//
//  Created by Paul Kirnoz on 07.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var queryString = ""
    @FocusState private var focusedField: Bool
    
    //List of contacts to display and filter through
    var searchDatabase: [String] = ["Arthur Morgan", "Dutch van der Linde", "Bill Williamson", "Javier Escuella", "John Marston", "Charles Smith", "Micah Bell", "Sadie Adler", "Hosea Matthews", "Lenny Summers", "Leopold Strauss", "Pearson"]
    
    //search and filter logic
    var searchResults: [String] {
        if queryString.isEmpty {
            return searchDatabase
        } else {
            return searchDatabase.filter { $0.localizedCaseInsensitiveContains(queryString) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $queryString)
                    .focused($focusedField)
                    .onTapGesture {
                        withAnimation {
                            focusedField = true
                        }
                        print("TextField tapped")
                    }
                    .padding(.vertical, 10)
                    .padding(.leading, 36)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            if focusedField && !queryString.isEmpty {
                                Button {
                                    self.queryString = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                                }
                            }
                        })
                
                ZStack {
                    List {
                        //displays filtered results in a list
                        ForEach(searchResults, id: \.self) { result in
                            NavigationLink {
                                Text(result)
                            } label: {
                                HStack {
                                    Image(systemName: "person.fill")
                                    Text(result)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                //change distance between cells
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                            }
                        }
                    }
                }
                .navigationTitle("Search")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
