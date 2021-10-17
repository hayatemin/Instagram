//
//  CommentViewController.swift
//  Instagram
//
//  Created by 横山颯 on 2021/10/17.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var textView: UILabel!
    
    var postData: PostData?// コメント対象となる投稿のデータ
    
    @IBAction func handlePostButton(_ sender: Any) {
        // コメント投稿者の表示名（設定を変えても変更前のままになる）
        let commenterDisplayName: String! = Auth.auth().currentUser!.displayName
        // textViewの内容をcommentとしてfirebaseに保存
        let comment: String! = self.textView.text!
        if (!comment.isEmpty) {
            // 投稿データの保存場所を定義する
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData!.id)
            // HUDで投稿処理中の表示を開始
            SVProgressHUD.show()
            // commentデータの追加
            var comments = postData!.comments
            comments.append([commenterDisplayName: comment])
            postRef.updateData(
                ["comments": comments]
            )
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // キャンセルボタンが押されたらホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
