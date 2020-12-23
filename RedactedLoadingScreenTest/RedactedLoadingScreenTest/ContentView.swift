//
//  ContentView.swift
//  RedactedLoadingScreenTest
//
//  Created by Matthias Zarzecki on 23.11.20.
//

import SwiftUI

struct ContentView: View {
  @State var posts: [Post]? = nil
  
  var loader: some View {
    if let unwrappedPosts = posts {
      return AnyView(
        List {
          ForEach(unwrappedPosts, id: \.self) { post in
            HStack{
              Circle()
                .frame(width: 60, height: 60, alignment: .leading)
              Text("\(post.body)")
            }
          }
        }
      )
    } else {
      return AnyView(
        ContentLoadingView()
      )
    }
  }
  
  var body: some View {
    loader
      .onAppear {
        Api().getPosts { posts in
          self.posts = posts
        }
      }
  }
}

struct ContentLoadingView: View {
  var body: some View {
    List {
      ForEach(TestClasses.testPosts, id: \.self) { post in
        HStack{
          Circle()
            .frame(width: 60, height: 60, alignment: .leading)
            .foregroundColor(.gray)
          Text("\(post.body)")
            .redacted(reason: .placeholder)
        }
      }
    }
  }
}

class TestClasses {
  static let testPosts = [
    Post(
      userId: 0,
      id: 1,
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    ),
    Post(
      userId: 0,
      id: 2,
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    ),
    Post(
      userId: 0,
      id: 3,
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    )
  ]
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView(posts: TestClasses.testPosts)
      ContentLoadingView()
      //Text("Loadingssssssssssssssss").redacted(reason: .placeholder)
    }
  }
}

