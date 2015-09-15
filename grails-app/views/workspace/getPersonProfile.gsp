<div class="col-md-6">
    <div class="form-group">
        <label class="col-md-3 control-label">姓</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:textField class="form-control" name="lastName" required="" value="${currentUser?.lastName}"/>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">性别</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="gender.id"  required=""
                          from="${com.bjrxht.enterprise.dictionary.Gender.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"   value="${currentUser?.gender?.id}"
                          id="genderId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">机构名称</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:textField class="form-control" name="organization" required="" value="${currentUser?.organization}"/>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">企业类型</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="companyType.id"  required=""
                          from="${com.bjrxht.cms.dictionary.CompanyType.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.companyType?.id}"
                          id="companyTypeId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">企业公开性</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="openness.id"  required=""
                          from="${com.bjrxht.cms.dictionary.Openness.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.openness?.id}"
                          id="opennessId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">所属行业</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="industryCatagory.id"  required=""
                          from="${com.bjrxht.cms.dictionary.Category.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.industryCatagory?.id}"
                          id="industryCatagoryId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>


</div>

<div class="col-md-6">
    <div class="form-group">
        <label class="col-md-3 control-label">名</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:textField class="form-control" name="firstName" required="" value="${currentUser?.firstName}"/>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">国籍</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="citizenship.id"  required=""
                          from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.citizenship?.id}"
                          id="citizenshipId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">公司职务</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:textField class="form-control" name="title" required="" value="${currentUser?.title}"/>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">企业规模</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="companyAssetSize.id"  required=""
                          from="${com.bjrxht.cms.dictionary.CompanyAssetSize.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.companyAssetSize?.id}"
                          id="companyAssetSizeId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">获得网站信息渠道</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="infoChannel.id"  required=""
                          from="${com.bjrxht.cms.dictionary.InfoChannel.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.infoChannel?.id}"
                          id="infoChannelId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>


</div>

<div class="col-md-12">
    <div class="form-group">
        <label class="col-md-3 control-label">办公地址</label>
        <div class="col-md-3">
        <g:select class="form-control select" name="officeCountry.id"  required=""
          from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
          optionKey="id" optionValue="name"  value="${currentUser?.officeCountry?.id}"
          id="officeCountryId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
        </div>
        <div class="col-md-6">
            <input type="text" name="officeLocation" value="${currentUser?.officeLocation}" class="form-control" placeholder="省/州+城市"/>
        </div>

</div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="col-md-3 control-label">感兴趣的行业</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="interestIndustrys" multiple="true"
                          from="${com.bjrxht.cms.dictionary.Category.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.interestIndustrys*.id}"
                          id="interestIndustrysId" style="width:100%;" title="-选择-"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
</div>
<div class="col-md-12">
<div class="form-group">
   <label class="col-md-3 control-label">感兴趣的国家</label>
   <div class="col-md-9">
       <div class="input-group">
           <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
            <g:select class="form-control select" name="interestCountrys" multiple="true"
                      from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                      optionKey="id" optionValue="name"  value="${currentUser?.interestCountrys*.id}"
                      id="interestCountrysId" style="width:100%;"  title="-选择-"></g:select>
        </div>
        <span class="help-block"><span class="required-indicator"></span></span>
    </div>
</div>
</div>





