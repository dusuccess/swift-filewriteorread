//
//  ViewController.swift
//  FileTest
//
//  Created by Sierra on 2018/3/21.
//  Copyright © 2018年 Sierra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(frame: CGRect(x: screenWidth/2-40, y: screenHeight/2-20, width: 80, height: 40))
        button.setTitle("文件读写", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(self.writeTofile), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func writeTofile(){
//        let manager = FileManager.default
//        let urlsForDocDirectory = manager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
//        var docPath:NSURL = urlsForDocDirectory[0] as NSURL
//        docPath = docPath.appendingPathComponent("myfolder2")! as NSURL
//        print(docPath)
//        let file = docPath.appendingPathComponent("test.txt")
//        createFile(name: "test.txt", fileBaseUrl: docPath)
        let string = "添加一些文字到文件末尾"
        let appendedData = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        XDFile.write(data: appendedData!, path: "myfolder/doc", filename: "test.txt")
//        let writeHandler = try? FileHandle(forWritingTo:file!)
//        writeHandler!.seekToEndOfFile()
//        writeHandler!.write(appendedData!)
        
        //方法1
//        let readHandler = try! FileHandle(forReadingFrom:file!)
////        let data = readHandler.readDataToEndOfFile()
//        readHandler.seek(toFileOffset: 33)
//        let data = readHandler.readData(ofLength: 33)
        let data = XDFile.read(path: "myfolder/doc", filename: "test.txt")
        let readString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print("文件内容1: \(readString)")
        
        //方法2
//        let data1 = manager.contents(atPath: file!.path)
//        let readString1 = NSString(data: data1!, encoding: String.Encoding.utf8.rawValue)
//        print("文件内容2: \(readString1)")
    }
    
    func createFile(name:String,fileBaseUrl:NSURL){
        let manager = FileManager.default
        
        let file = fileBaseUrl.appendingPathComponent(name)
        try! manager.createDirectory(at: fileBaseUrl as URL, withIntermediateDirectories: true, attributes: nil)
        print("文件: \(file)")
        let exist = manager.fileExists(atPath: file!.path)
        if !exist {
            let data = NSData(base64Encoded:"aGVsbG8gd29ybGQ=",options:.ignoreUnknownCharacters)
            let createSuccess = manager.createFile(atPath: file!.path,contents:nil,attributes:nil)
            print("文件创建结果: \(createSuccess)")
        }
        
        do {
            let filepath = file?.absoluteString.replacingOccurrences(of: "file://", with: "")
            let attr = try manager.attributesOfItem(atPath: filepath!)
            let size = attr[FileAttributeKey.size] as! UInt64
            print("文件大小：\(size)")
        } catch  {
            print("error :\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

