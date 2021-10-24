//
//  PostData.swift
//  Instagram
//
//  Created by 横山颯 on 2021/10/16.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [Dictionary<String, String>] = []// 同一ユーザーが複数回コメントすることも考えられるので[uid: comment]という辞書を一つずつ格納する配列を考える
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        print("postDic[comments]")
        if let comments = postDic["comments"] as? [Dictionary<String, String>] {
           print(comments)
            self.comments = comments
        }
    }
}
