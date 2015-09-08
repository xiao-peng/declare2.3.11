package com.bjrxht.core
  //访问控制表
class Requestmap {
	static auditable = true
	  //url地址
	String url
	//授权角色
	String configAttribute

	static mapping = {
		cache true
	}

	static constraints = {
		url blank: false, unique: true
		configAttribute blank: false
	}
	String toString(){
		return url;
	}
}
