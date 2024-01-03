//
//  IssuePageView.swift
//  Yangzhou
//

import Foundation
import SwiftUI
import UIKit



struct IssuePageView : View {
    @EnvironmentObject var userData:UserData
    
    @State var showWriteIssue=false
    @State var activityIssue=false
    @State var searchPartyIssue=false
    @State var ihomeIssue=false
    
    
    
    var body : some View {
        VStack{
            HStack {
                Image("ticket")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .clipped()
                Text("\n")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.red)
                    .padding(.leading, 20)
                    .padding(.top, -40)
                Spacer()
            }
            HStack{
            Button(
                action: { self.showWriteIssue = true }, label: {
                    VStack {
                        //Image(systemName: "plus.square")
                        //   .font(.system(size: 35))
                        //    .foregroundColor(Color.gray.opacity(0.85)).padding(10)
                        Image("suggestion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .clipped()
                        Text("表达意见")
                            .foregroundColor(Color.black.opacity(0.85))
                        .font(.system(size: 17))}
                    .frame(width: 130, height: 130)
                    //.background(Color.gray.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [10])))})
            .sheet(isPresented: self.$showWriteIssue,content:
                    { WriteIssueView { titleText,content in
                
                self.userData.issues.insert(Issue(id: self.userData.issues.count, type: 1, title: titleText, content: content), at: 0)
                
                
                let encoder = JSONEncoder()
                do  {
                    // 将player对象encod（编码）
                    let data: Data = try encoder.encode(self.userData.issues)
                    let filename = getDocumentsDirectory().appendingPathComponent("Issue.json")
                    try? data.write(to: filename)
                } catch {
                    
                }
                
            }})
            
            Button(
                action: {
                    
                    
                 
                    
                    
                    self.activityIssue = true }, label: {
                    VStack {
                        //Image(systemName: "plus.square")
                          //  .font(.system(size: 35))
                          //  .foregroundColor(Color.gray.opacity(0.85)).padding(10)
                        Image("activity")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90)
                            .clipped()
                        Text("申请活动")
                            .foregroundColor(Color.blue.opacity(0.85))
                        .font(.system(size: 17))}
                    .frame(width: 130, height: 130)
                    //.background(Color.blue.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [10])))})
            .sheet(isPresented: self.$activityIssue,content:
                    { ActivityView { titleText,target,money,content in
                
                self.userData.issues.insert(Issue(id: self.userData.issues.count, type: 2, title: titleText,
            target:target,money:money,content: content), at: 0)
                let encoder = JSONEncoder()
                do  {
                    // 将player对象encod（编码）
                    let data: Data = try encoder.encode(self.userData.issues)
                    let filename = getDocumentsDirectory().appendingPathComponent("Issue.json")
                    try? data.write(to: filename)
                } catch {
                    
                }
                
            }})
            
        }
            
            HStack{
                Button(
                    action: { self.searchPartyIssue = true }, label: {
                        VStack {
                            //Image(systemName: "plus.square")
                            //    .font(.system(size: 35))
                            //    .foregroundColor(Color.gray.opacity(0.85)).padding(10)
                            Image("ticket")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                                .clipped()
                            Text("入园码查询")
                                .foregroundColor(Color.red.opacity(0.85))
                            .font(.system(size: 17))}
                        .frame(width: 130, height: 130)
                        //.background(Color.gray.opacity(0.2))
                        .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [10])))})
                .sheet(isPresented: self.$searchPartyIssue,content:
                        { PartyView()/* { personID,personName in
                    
                    
                    
                    self.userData.issues.insert(Issue(id: self.userData.issues.count, type: 3, personID:personID, personName: personName), at: 0)
                }*/
                    
                })
                
                Button(
                    action: { self.ihomeIssue = true }, label: {
                        VStack {
                            //Image(systemName: "plus.square")
                            //    .font(.system(size: 35))
                            //    .foregroundColor(Color.gray.opacity(0.85)).padding(10)
                            Image("complaint")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90)
                                .clipped()
                            Text("权益维护")
                                .foregroundColor(Color.yellow.opacity(0.85))
                            .font(.system(size: 17))}
                        .frame(width: 130, height: 130)
                        //.background(Color.gray.opacity(0.2))
                        .overlay(RoundedRectangle(cornerRadius:10).stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [10])))})
                .sheet(isPresented: self.$ihomeIssue,content:
                        { ihomeIssueView { titleText,department,content in
                    
                    self.userData.issues.insert(Issue(id: self.userData.issues.count, type: 4, title: titleText,department:department, content: content), at: 0)
                    
                    let encoder = JSONEncoder()
                    do  {
                        // 将player对象encod（编码）
                        let data: Data = try encoder.encode(self.userData.issues)
                        let filename = getDocumentsDirectory().appendingPathComponent("Issue.json")
                        try? data.write(to: filename)
                    } catch {
                        
                    }
                }})
                
            
            }
            IssueList()
        }
    }
}

struct ActivityView : View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var titleText = ""
    @State var target = ""
    @State var money = 0
    @State var content = ""
    
    let onIssueFinished: (String,String,Int,String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("标题")) {
                    TextField("请输入标题", text: $titleText)
                }
                
                Section(header: Text("目标")) {
                    TextField("请输入目标", text: $target)
                }
                
                Section(header: Text("预算")) {
                    TextField("请输入预算", value: $money, formatter: NumberFormatter())
                }
                
                Section(header: Text("内容")) {
                    TextField("请输入内容", text: $content)
                }
                
                Section {
                    Button(action: {
                        self.onIssueFinished(self.titleText,self.target,self.money,self.content)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("提交")
                                .bold()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle(Text("创建活动"), displayMode: .inline)
        }
    }
}

struct PartyView: View {
    @EnvironmentObject var userData:UserData
    @Environment(\.presentationMode) var presentationMode
    
    @State var personID=""
    @State var personName=""
    @State var nullAlert=false
    @State var result=""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("身份证号")) {
                    TextField("请输入身份证号", text: $personID)
                }
                
                Section(header: Text("姓名")) {
                    TextField("请输入姓名", text: $personName)
                }
                
                Section(header: Text("入园码查询")) {
                    Text("\(result)")
                }
                
                Section {
                    Button(action: {
                        let u = self.userData.users.filter{$0.name == self.personName}
                        if(u.isEmpty){
                            self.nullAlert=true
                        } else {
                            let t = u.filter{$0.number == self.personID}
                            if(t.isEmpty){
                                self.nullAlert=true
                            }
                            else {
                                self.result=t[0].progress
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("查询")
                                .bold()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .alert(isPresented: $nullAlert) {
                        Alert(title: Text("查询失败"), message: Text("身份证号或姓名错误"))
                    }
                }
                
                Section {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "xmark")
                            Text("返回")
                                .bold()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle(Text("查询进度"), displayMode: .inline)
        }
    }
}
// Improved ihomeIssueView
struct ihomeIssueView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var titleText=""
    @State var department=""
    @State var content=""
    
    let onIssueFinished: (String,String,String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("标题")) {
                    TextField("请输入标题", text: $titleText)
                }
                
                Section(header: Text("部门")) {
                    TextField("请输入部门", text: $department)
                }
                
                Section(header: Text("权益申请")) {
                    TextField("请输入权益申请", text: $content)
                }
                
                Section {
                    Button(action: {
                        self.onIssueFinished(self.titleText, self.department, self.content)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("提交")
                                .bold()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle(Text("权益申请"), displayMode: .inline)
        }
    }
}

// Improved WriteIssueView
struct WriteIssueView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var titleText=""
    @State var content=""
    
    let onIssueFinished: (String,String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("标题")) {
                    TextField("请输入标题", text: $titleText)
                }
                
                Section(header: Text("提案")) {
                    TextField("请输入提案内容", text: $content)
                }
                
                Section {
                    Button(action: {
                        self.onIssueFinished(self.titleText, self.content)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("提交")
                                .bold()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle(Text("提交提案"), displayMode: .inline)
        }
    }
}
