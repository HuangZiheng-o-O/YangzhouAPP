//
//  onBoardingPage.swift
//  Yangzhou
//

// 欢迎页面滚播图

import Foundation

struct Page : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
}

var loadingData = [
Page(id: 0, image: "entrance1", title: "游在扬州全新体验", descrip: "沉浸在扬州瘦西湖的美丽景色中，尽情享受独特的旅行体验。"),
Page(id: 1, image: "entrance2", title: "精准定位，一键导航", descrip: "利用智能导航系统，轻松找到扬州瘦西湖的各个景点，畅游无忧。"),
Page(id: 2, image: "entrance3", title: "向扬州旅游局提出你的想法", descrip: "与扬州旅游局分享你对扬州瘦西湖的想法和建议，共同打造更美好的旅行体验。"),
Page(id: 3, image: "entrance4", title: "查看你的出行一卡通", descrip: "查看你的出行卡号，方便快捷地畅游扬州瘦西湖。")
]
