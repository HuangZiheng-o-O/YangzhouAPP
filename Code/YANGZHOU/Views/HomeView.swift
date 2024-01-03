//
//  HomeView.swift
//  Yangzhou
//

import SwiftUI

// Home视图
//瘦西湖

struct HomeView: View {
    @State var search: String = ""
      @State var searchResults: [Article] = []

    //@EnvironmentObject var userData:UserData
    @State var hero = false
    @State var data = articleData
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    SearchBar(search: $search)
                              
                              List(searchResults) { article in
                                  Text(article.title)
                              }
                    
                    //TrendingWeek
                    VStack{
                        HStack {
                            Text("景区导航")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 20)
                            
                            Spacer()
                            Text("浏览更多 >>")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(#colorLiteral(red: 0.3403331637, green: 0.10593573, blue: 0.9580881, alpha: 1)))
                                .padding(.trailing, 20)
                        }
                        // 首页滚播
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(articleData) { card in
                                    NavigationLink(
                                         destination: ArticleView(article :card),
                                        label: {
                                            TrendingWeek(trendingMeal: card)
                                                .background(Color.white)
                                                .cornerRadius(15)
                                                .shadow(radius: 1)
                                        })
                                        .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.bottom, 10)
                                .padding(.leading, 30)
                            } 
                        }
                    }.padding(.top, -50)
                    .opacity(self.hero ? 0 : 1)
                    
                    
                    //Categories
                    VStack{
                        HStack {
                            Text("分类")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        // Categories View
                        //ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1 ..< 4) { i in
                                    NavigationLink(
                                        destination: ArticleListView(data: data.filter{ $0.type == articleTypes[Int(i)-1] }),
                                        label: {
                                            VStack {
                                                Image("categ-\(String(i))")
                                                Text(articleTypes[Int(i)-1])
                                                    .font(.subheadline)
                                                    .bold()
                                            }
                                            .frame(minWidth:0, maxWidth:.infinity, minHeight: 100)
                                            //.frame(width: 80, height: 100, alignment: .center, minWidth:0, maxWidth:.infinity)
                                            .background(Color.white)
                                            .cornerRadius(15)
                                        })
                                }
                                .padding(.horizontal)
                                //.padding(.bottom, 10)
                                //.padding(.leading, 30)
                            }
                        //}
         
                        
                    }
                    .shadow(radius: 1)
                    .opacity(self.hero ? 0 : 1)
                    
                    //Our picks
                    VStack{
                        HStack {
                            Text("玩在扬州")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 20)
                            
                            Spacer()
                            Text("下滑浏览更多")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(#colorLiteral(red: 0.3403331637, green: 0.10593573, blue: 0.9580881, alpha: 1)))
                                .padding(.trailing, 20)
                        }
                        .opacity(self.hero ? 0 : 1)
                        
                        
                        // Card View
                        VStack(spacing: 100) {
                            ForEach(0..<self.data.count){i in
                                GeometryReader{g in
                                    OurPicks(card: self.$data[i], hero: self.$hero)
                                        
                                        .offset(y: self.data[i].isStared ? -g.frame(in: .global).minY : 0)
                                        .opacity(self.hero ? (self.data[i].isStared ? 1 : 0) : 1)
                                        .onTapGesture {
                                            
                                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                                                if !self.data[i].isStared{
                                                    self.hero.toggle()
                                                    self.data[i].isStared.toggle()
                                                } }}}
                                .frame(height: self.data[i].isStared ? UIScreen.main.bounds.height : 250)
                            }
                        }  }.padding(.top, 50)
                    .padding(.bottom, 150)
                    
                    Spacer()
                    
                    
                }
                .background(Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1)))
                
            }
            .background(Color(#colorLiteral(red: 0.3403331637, green: 0.10593573, blue: 0.9580881, alpha: 1)))
            .edgesIgnoringSafeArea(.top)
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct SearchBar: View {
    @Binding var search: String
       @State private var isSearching = false
       @State private var filteredArticles: [Article] = []
       @State private var searchSuggestions: [Article] = []
       @State private var showSuggestions = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
            
           
                   VStack {
                       HStack {
                           TextField("Search...", text: $search)
                               .font(.title3)
                               .onChange(of: search) { value in
                                   if !value.isEmpty {
                                       searchSuggestions = articleData.filter { $0.title.lowercased().contains(value.lowercased()) }
                                   } else {
                                       searchSuggestions = []
                                   }
                               }
                           
                           Button(action: {
                               self.filteredArticles = searchSuggestions
                               isSearching = true
                           }) {
                               Image(systemName: "magnifyingglass")
                                   .foregroundColor(.gray)
                                   .font(.title)
                           }
                       }
                       .frame(height: 30, alignment: .leading)  // Reduce the height of search bar
                       .padding(.horizontal, 20)  // Add horizontal padding
                       .background(Color.white)
                       .cornerRadius(10)
                       
                       // Show search suggestions
                       if !searchSuggestions.isEmpty {
                           List(searchSuggestions, id: \.id) { article in
                               Text(article.title)
                                   .onTapGesture {
                                       search = article.title
                                   }
                           }
                           .frame(height: 100)  // Adjust the height of the suggestion list
                           .overlay(
                               RoundedRectangle(cornerRadius: 15)
                                   .stroke(Color.gray, lineWidth: 0.5)
                           )
                       }
                   }
//                   .sheet(isPresented: $isSearching) {
//                       ArticleListView(data: filteredArticles).environmentObject(UserData())
//                           .padding(.top, 50)  // Add top padding to the article list view
//                   }
                   .sheet(isPresented: $isSearching) {
                       ArticleListView(data: filteredArticles).environmentObject(UserData())
                           .padding(.top, 50)  // Add top padding to the article list view
                   }
               }
        
    }
}
