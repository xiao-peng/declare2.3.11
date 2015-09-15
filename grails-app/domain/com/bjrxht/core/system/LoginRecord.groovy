package com.bjrxht.core.system

import com.bjrxht.cms.core.BaseUser
import com.bjrxht.core.BaseUser

import java.sql.Timestamp

//
class LoginRecord {

	BaseUser baseUser
	String remoteaddr
	String sessionId
	Date loginTime
	Date logoutTime
	Timestamp dateCreated
	Timestamp lastUpdated
	static constraints = {
		baseUser (nullable:false)
		remoteaddr(size:0..50,blank: true,nullable:true)
		sessionId(size:0..100,blank: true,nullable:true) //unique: true
		loginTime(nullable: false)
		logoutTime(nullable: true)
	}

	static mapping = {
	}
	String toString(){
		return "${baseUser} from ${remoteaddr} login system at ${dateCreated.format('yyyy-MM-dd hh:mm ss')}";
	}
}
