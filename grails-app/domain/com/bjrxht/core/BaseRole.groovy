package com.bjrxht.core

import com.bjrxht.grails.annotation.Title

@Title(zh_CN='基本角色表')
class BaseRole{ // implements org.activiti.engine.identity.Group {
	static auditable = true
	//uuid的唯一性主键 兼容 activiti工作流
	String id
	//角色名称
	String name
	//角色权限（与名称相同）
	String authority
	//中文描述
	String description
	//类型 （目前未使用，设为null）
	String type


	static mapping = {
		cache true
		id generator: 'assigned'
	}

	static constraints = {
		authority blank: false, unique: true
		name blank: false
		description blank: false
		type nullable: true
	}
	String toString(){
		return name;
	}
}
