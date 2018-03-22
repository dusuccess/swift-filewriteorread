//
//  XDFile.swift
//  FileTest
//
//  Created by Sierra on 2018/3/21.
//  Copyright © 2018年 Sierra. All rights reserved.
//

import UIKit

class XDFile:NSObject{
    
    override init() {
        super.init()
    }
    
    public static func write(data:Data,path:String,filename:String)->Bool{
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
        var docPath:NSURL = urlsForDocDirectory[0] as NSURL
        let pathUrl = docPath.appendingPathComponent(path)
        let isExist = self.createFile(name: filename, fileBaseUrl: pathUrl!)
        if(isExist){
            let file = pathUrl?.appendingPathComponent(filename)
            do{
                let writeHandler = try? FileHandle(forWritingTo:file!)
                writeHandler!.seekToEndOfFile()
                writeHandler!.write(data)
                return true
            } catch  {
                print("fileerror :\(error)")
                return false
            }
        }else{
            return true
        }
    }
    
    public static func read(path:String,filename:String)->Data{
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
        var docPath:NSURL = urlsForDocDirectory[0] as NSURL
        var data = Data.init()
        let pathUrl = docPath.appendingPathComponent(path)
        let file = pathUrl?.appendingPathComponent(filename)
        try! manager.createDirectory(at: pathUrl!, withIntermediateDirectories: true, attributes: nil)
        let exist = manager.fileExists(atPath: (file?.path)!)
        if(exist){
            let readHandler = try! FileHandle(forReadingFrom:file!)
            data = readHandler.readDataToEndOfFile()
            //            readHandler.seek(toFileOffset: 30)
            //            let data = readHandler.readData(ofLength: 33)
            return data
        }
        return data
    }
    
    static func createFile(name:String,fileBaseUrl:URL)->Bool{
        let manager = FileManager.default
        print(fileBaseUrl)
        let file = fileBaseUrl.appendingPathComponent(name)
        try! manager.createDirectory(at: fileBaseUrl, withIntermediateDirectories: true, attributes: nil)
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            let createSuccess = manager.createFile(atPath: file.path,contents:nil,attributes:nil)
            return createSuccess
        }
        return true
    }
}
