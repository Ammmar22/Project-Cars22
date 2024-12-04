//
//  NewsFeedView.swift
//  Project Cars22
//
//  Created by Abderrahmen on 03/12/2024.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()

    var body: some View {
        ZStack
        {
            Image("fond2")
                .resizable()             // Make the image resizable
                .scaledToFill()          // Fill the screen with the image, cropping if necessary
                .ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(newsFeed) { article in
                            NewsCardView(article: article)
                                .onAppear {
                                    self.newsFeed.loadMoreArticles(currentItem: article)
                                }
                        }
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, 15)
                }
                .navigationTitle("News")
            
        }
    }
}

struct NewsCardView: View {
    var article: NewsListItem
    
    var body: some View {
        
        
        
        VStack(alignment: .leading) {
            if let imageUrl = article.urlToImage, !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(article.author ?? "Unknown Author")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                NavigationLink(destination: NewsListItemView(article: article)) {
                    HStack {
                        Image(systemName: "car.fill")
                            .foregroundColor(.white)
                        Text("Read More")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
                    .shadow(radius: 5)
                }


            }
            .padding()
        }
        .background(Color.white.opacity(0.7))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct NewsListItemView: View {
    var article: NewsListItem
    
    var body: some View {
        VStack {
            UrlWebView(urlToDisplay: URL(string: article.url)!)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle(article.title, displayMode: .inline)
        }
    }
}


#Preview {
    NewsFeedView()
}
