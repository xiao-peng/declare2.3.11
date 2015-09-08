package com.bjrxht.mongodb.gridfs

import grails.transaction.Transactional
import com.mongodb.gridfs.GridFS
import com.mongodb.gridfs.GridFSDBFile
import com.mongodb.gridfs.GridFSInputFile
import org.bson.types.ObjectId
import com.bjrxht.mongodb.gridfs.FileItem

/**
 * 文件管理服务
 * 通过Mongo GRIDFS 服务提供文件的存储
 * 通过FileItem表记录真实文件名与GRID FS ID的关联
 */
@Transactional
class FileMgmtService {

    static transactional = false
    def mongo
    def grailsApplication
    def securityService

    /**
     * 上传文件保存到集中存储的地方
     * @return
     */

    FileItem saveFile(String fileName, byte[] fileData, String contentType, String fileDescription) {

        //存储GridFS数据库
        GridFS gridFS = new GridFS(mongo.getDB(grailsApplication.config.grails.mongo.databaseName))

        GridFSInputFile gridFSInputFile = gridFS.createFile(fileData)
        gridFSInputFile.filename = fileName
        gridFSInputFile.contentType = contentType
        gridFSInputFile.save()

        //存储FileItem表
        FileItem fileItem = new FileItem()
        fileItem.fileDescription = fileDescription
        fileItem.fileName = fileName
        fileItem.createdBy = securityService.currentUserName
        fileItem.dateCreated = new Date()
        fileItem.fileSize = fileData.size()
        fileItem.fileType = contentType
        fileItem.fsId = gridFSInputFile.id.toString()
        fileItem.save(flush: true, validate: false)

        return fileItem
    }

    //删除文件必须通过该服务，同时删除FileItem和GridFS文件
    void deleteFile(String fileItemId) {
        FileItem fileItem = FileItem.findById(new ObjectId(fileItemId))

        if(fileItem){
            GridFS gridFS = new GridFS(mongo.getDB(grailsApplication.config.grails.mongo.databaseName))
            gridFS.remove(new ObjectId(fileItem.fsId))
            fileItem.delete()
        }
    }

    //获取真正文件数据
    byte[] getFileData(String fileItemId) {
        FileItem fileItem = FileItem.findById(new ObjectId(fileItemId))

        if(fileItem){
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()
            GridFS gridFS = new GridFS(mongo.getDB(grailsApplication.config.grails.mongo.databaseName))
            GridFSDBFile gridFSDBFile = gridFS.find(new ObjectId(fileItem.fsId))
            if(gridFSDBFile){
                gridFSDBFile.writeTo(byteArrayOutputStream)
            }
            return byteArrayOutputStream.toByteArray()
        }else{
            return null
        }

    }
    //大文件按流处理，可以跳过skip，只读部分 read
    InputStream getFileStream(String fileItemId){
        FileItem fileItem = FileItem.findById(new ObjectId(fileItemId))

        if(fileItem){
            // ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()
            GridFS gridFS = new GridFS(mongo.getDB(grailsApplication.config.grails.mongo.databaseName))
            GridFSDBFile gridFSDBFile = gridFS.find(new ObjectId(fileItem.fsId))
            if(gridFSDBFile){
                // gridFSDBFile.writeTo(byteArrayOutputStream)
                return gridFSDBFile.inputStream;
            }else{
                return null;
            }
            //return byteArrayOutputStream.toByteArray()
        }else{
            return null
        }
    }
}
