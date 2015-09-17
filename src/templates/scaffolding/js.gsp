<script>
    function deleteFormatter(value, row) {
        var str='<button class="btn btn-default margin" onclick="deleteOne('+row.id+')" type="button"><span class="glyphicon glyphicon-trash"></span> &nbsp;<g:message code="default.button.delete.label" default="Delete" /></button></a>';
        return str;
    }
    function editFormatter(value, row,index) {
        var str='<button class="btn btn-default margin box-switcher" data-switch="box-edit" onclick="editOne('+index+','+row.id+')"  type="button"><span class="glyphicon glyphicon-edit"></span> &nbsp;<g:message code="default.button.edit.label" default="Edit" /></button></a>';
        return str;
    }
    function nameFormatter(value, row,index) {
        var str='<a href="javascript:void(0);" class="box-switcher" data-switch="box-edit" onclick="editOne('+index+','+row.id+')" >'+row.name+'</a>';
        return str;
    }
    function queryParams(params) {
        //params.your_param1 = 1;
        return params;
    }
    function deleteAll(){
        var selects=\$('#${domainClass.propertyName}Table').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            var obj=new Object();
            obj.ids=ids.join(",");
            if(confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) {
                \$.post("\${request.contextPath}/${domainClass.propertyName}/deleteAll", obj,
                        function (data, textStatus) {
                            if (data.result) {
                                \$('#alertSucess').removeClass('hide');
                                setTimeout(function(){
                                    \$('#alertSucess').addClass('hide');
                                }, 2000);
                                \$('#${domainClass.propertyName}Table').bootstrapTable('refresh',[]);
                            } else {
                                \$('#alertFault').removeClass('hide');
                            }
                        }, "json");
            }
        }
    }
    function newOne(){
        \$('#editForm').form('clear');
    }
    function deleteOne(id){

    }
    function editOne(index,id){
        \$('#editForm').form('clear');
        var data=\$('#${domainClass.propertyName}Table').bootstrapTable('getData');
        \$('#editForm').form('load',data[index]);

        if(data[index]['parent.id'] && data[index]['parent.id']!=null){
            \$("#parent option[value='"+data[index][parent.id]+"']").remove();
            \$("#parent").prepend("<option value='"+data[index]['parent.id']+"'>"+data[index]['parent.text']+"</option>");
        }
    }
    function showOne(index,id){
        editOne(index,id);
    }
    function importExcel(){
        \$('#excelForm').form('submit', {
            url:'\${request.contextPath}/${domainClass.propertyName}/importExcel',
            success: function(data){
                var data = eval('(' + data + ')'); // change the JSON string to javascript object
                \$('#importModal').modal('hide');
                if (data.result){
                    \$('#alertSucess').removeClass('hide');
                    setTimeout(function(){
                        \$('#alertSucess').addClass('hide');
                    }, 2000);
                    \$('#${domainClass.propertyName}Table').bootstrapTable('refresh',[]);
                }else{
                    \$('#alertFault').removeClass('hide');
                }
            }
        });
    }
    \$(function(){
        \$('#editForm').form({
            success: function(data){
                var data = eval('(' + data + ')'); // change the JSON string to javascript object
                if (data.result){
                    \$('#alertSucess').removeClass('hide');
                    setTimeout(function(){
                        \$('#alertSucess').addClass('hide');
                    }, 2000);
                    \$('#box-edit').closest('.box').toggleClass('active');
                    \$('#box-list').closest('.box').addClass('active');
                    \$('#${domainClass.propertyName}Table').bootstrapTable('refresh',[]);
                }else{
                    \$("#faultMessage").html(data.message);
                    \$('#alertFault').removeClass('hide');
                }
            }
        });
        \$('#${domainClass.propertyName}Table').bootstrapTable({});
    });
</script>
