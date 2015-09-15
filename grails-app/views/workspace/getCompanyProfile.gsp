<%@ page import="com.bjrxht.cms.core.Contact" %>
<div class="col-md-6">

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
        <label class="col-md-3 control-label">所属行业</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="industryCatagory.id"
                          from="${com.bjrxht.cms.dictionary.Category.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.industryCatagory?.id}"
                          id="industryCatagoryId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>



    <div class="form-group">
        <label class="col-md-3 control-label">总部所在地</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="headquarters.id"
                          from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.headquarters?.id}"
                          id="headquartersId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>



    <div class="form-group">
        <label class="col-md-3 control-label">机构性质</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="companyType.id"
                          from="${com.bjrxht.cms.dictionary.CompanyType.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.companyType?.id}"
                          id="companyTypeId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>


    <div class="form-group">
        <label class="col-md-3 control-label">机构公开性</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="openness.id"
                          from="${com.bjrxht.cms.dictionary.Openness.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.openness?.id}"
                          id="opennessId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label class="col-md-3 control-label">机构规模（人数）</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="companyStaffSize.id"
                          from="${com.bjrxht.cms.dictionary.CompanyStaffSize.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.companyStaffSize?.id}"
                          id="companyStaffSizeId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 control-label">机构规模(资产)</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="companyAssetSize.id"
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
                <g:select class="form-control select" name="infoChannel.id"
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
        <label class="col-md-3 control-label">办公地点</label>
        <div class="col-md-3">
            <g:select class="form-control select" name="officeCountry.id"
                      from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                      optionKey="id" optionValue="name"  value="${currentUser?.officeCountry?.id}"
                      id="officeCountryId" style="width:100%;" noSelection="['':'-选择-']"></g:select>
        </div>
        <div class="col-md-6">
            <input type="text" name="officeLocation" class="form-control" value="${currentUser?.officeLocation}" placeholder="省/州+城市"/>
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
                          id="interestCountrysId" style="width:100%;" title="-选择-"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="col-md-3 control-label">服务领域</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="serviceAreas" multiple="true"
                          from="${com.bjrxht.cms.dictionary.ServiceArea.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.serviceAreas*.id}"
                          id="serviceAreasId" style="width:100%;"  title="-选择-"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label class="col-md-3 control-label">优势国家</label>
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                <g:select class="form-control select" name="advantageCountrys" multiple="true"
                          from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                          optionKey="id" optionValue="name"  value="${currentUser?.advantageCountrys*.id}"
                          id="advantageCountrysId" style="width:100%;"  title="-选择-"></g:select>
            </div>
            <span class="help-block"><span class="required-indicator"></span></span>
        </div>
    </div>
</div>

<div class="col-md-12" >
    <div class="form-group">
        <label class="col-md-9 control-label"style="text-align: center">
            联系人信息</label>
        <div class="col-md-3">
            <button class="btn btn-success" onclick="addContact();return false;">
                <i class="fa fa-plus"></i>
            </button>
            <button class="btn btn-success" onclick="remoteContact();return false;">
                <i class="fa fa-minus"></i>
            </button>
        </div>
        <span class="help-block"><span class="required-indicator"></span></span>
    </div>
</div>
<g:set var="contacts" value="${Contact.findAllByBaseUser(currentUser,['sort':'id','order':'asc'])}"/>
<div id="allContactDiv">
<g:each in="${contacts}" var="contact" status="i">
    <div class="col-md-12">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">
                    联系人姓名</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactName" value="${contact.contactName}" class="form-control" placeholder="姓名"/></div>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-3 control-label">
                    电话</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactPhone" value="${contact.contactPhone}" class="form-control" placeholder="电话"/></div>
                </div>
            </div>

        </div>

        <div class="col-md-6">

            <div class="form-group">
                <label class="col-md-3 control-label">
                    邮箱</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactEmail" value="${contact.contactEmail}" class="form-control" placeholder="邮箱"/></div>
                    <span class="help-block"><span class="required-indicator"></span></span>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-3 control-label">
                    职位</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactTitle" value="${contact.contactTitle}" class="form-control" placeholder="职位"/></div>
                    <span class="help-block"><span class="required-indicator"></span></span>
                </div>
            </div>


        </div>
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-md-3 control-label">
                    地址</label>
                <div class="col-md-3">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <div class="selectParentDiv">
                        <g:select class="form-control select" name="contactCountry.id"   id="contactCountryId${i}"
                                  from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                                  optionKey="id" optionValue="name"  value="${contact.contactCountry?.id}"
                                  style="width:100%;" noSelection="['':'-选择-']"></g:select>
                         </div>
                        </div>
                </div>
                <div class="col-md-6">
                    <input type="text" name="contactLocation" value="${contact.contactLocation}" class="form-control" placeholder="省/州+城市"/>
                </div>
            </div>
        </div>
    </div>
</g:each>
<g:if test="${contacts.size()==0}">
    <div class="col-md-12">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">
                    联系人姓名</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactName" value="" class="form-control" placeholder="姓名"/></div>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-3 control-label">
                    电话</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactPhone" value="" class="form-control" placeholder="电话"/></div>
                </div>
            </div>

        </div>

        <div class="col-md-6">

            <div class="form-group">
                <label class="col-md-3 control-label">
                    邮箱</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactEmail" value="" class="form-control" placeholder="邮箱"/></div>
                    <span class="help-block"><span class="required-indicator"></span></span>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-3 control-label">
                    职位</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <input type="text" name="contactTitle" value="" class="form-control" placeholder="职位"/></div>
                    <span class="help-block"><span class="required-indicator"></span></span>
                </div>
            </div>


        </div>
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-md-3 control-label">
                    地址</label>
                <div class="col-md-3">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <div class="selectParentDiv">
                            <g:select class="form-control select"  name="contactCountry.id"  id="contactCountryId-1"
                                      from="${com.bjrxht.cms.dictionary.Country.list(['sort':'id','order':'asc'])}"
                                      optionKey="id" optionValue="name"  value=""
                                      style="width:100%;" noSelection="['':'-选择-']"></g:select></div>
                        </div>

                </div>
                <div class="col-md-6">
                    <input type="text" name="contactLocation" value="" class="form-control" placeholder="省/州+城市"/>
                </div>
            </div>
        </div>
    </div>
</g:if>

</div>
