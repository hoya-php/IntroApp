//
//  BuzzTableViewController.swift
//  IntroApp
//
//  Created by 伊藤和也 on 2020/07/14.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import SegementSlide

class BuzzNewsTableViewController: UITableViewController,
SegementSlideContentScrollViewDelegate,
XMLParserDelegate {
    
    var parser = XMLParser()
    
    //RSSparser の要素取得
    var currentElementName: String!
    var newsItem = [NewsItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //テーブルビューレイアウト　セルのハイライトを消す
        tableView.separatorStyle = .none
        
        //画像をTableViewの後ろに配置する。
        let backImage = UIImage(named: "4")
        let backImageView = UIImageView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: self.tableView.frame.size.width,
                                                      height: self.tableView.frame.size.height))
        
        backImageView.image = backImage
        self.tableView.backgroundView = backImageView
        
        
        //XML parser
        let urlString = "https://news.yahoo.co.jp/pickup/rss.xml"
        let url: URL = URL(string: urlString)!
        
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
    }
    
    // MARK: - XMLparser functions
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        //itemタグが見つかるたびに、newsItemの末尾に追加していく。
        if elementName == "item" {

            self.newsItem.append(NewsItem())
            
        } else {
            
            currentElementName = elementName
            
        }
        
    }
    
    //各タグごとに を仕分けする 関数
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.newsItem.count > 0 {
            
            let lastItem = self.newsItem[self.newsItem.count - 1]
            
            switch self.currentElementName {
                
                case "title":
                    lastItem.title = string
                
                case "link":
                    lastItem.link = string
                
                case "pubDate":
                    lastItem.pubDate = string
                
                default: break
                
            }
        }
    }
    
    //各タグの終了　を仕分けする　関数
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        self .currentElementName = nil
        
    }
    
    //ドキュメントのXML解析が終了したら、テーブルビューを更新。
    func parserDidEndDocument(_ parser: XMLParser) {
        
        self.tableView.reloadData()
        
    }
    
    
    // MARK: - Table view data source
    @objc var scrollView: UIScrollView {
        return tableView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indexRow = indexPath.row
        let cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: "Cell")
        
        cell.backgroundColor = .clear
        let newsItem = self.newsItem[indexRow]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        cell.detailTextLabel?.text = newsItem.link
        cell.detailTextLabel?.textColor = .white
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItem.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexRow: Int = indexPath.row
        //WebViewにURLを渡し、表示したい。
        let webViewKit = WebViewKit()
        //表示する方法をModalにし、.crossDissolveアニメーションを使用
        webViewKit.modalTransitionStyle = .crossDissolve
        
        let newsitem = newsItem[indexRow]
        UserDefaults.standard.set(newsitem.link, forKey: "link")
        
        present(webViewKit,
                animated: true,
                completion: nil)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
