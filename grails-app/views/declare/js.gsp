<g:if test="${!params.layout}">
    <script>
</g:if>
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
        var selects=$('#table').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            var obj=new Object();
            obj.ids=ids.join(",");
            if(confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) {
                $.post("${request.contextPath}/declare/deleteAll", obj,
                        function (data, textStatus) {
                            if (data.result) {
                                $('#alertSucess').removeClass('hide');
                                setTimeout(function(){
                                    $('#alertSucess').addClass('hide');
                                }, 2000);
                                $('#table').bootstrapTable('refresh',[]);
                            } else {
                                $('#alertFault').removeClass('hide');
                            }
                        }, "json");
            }
        }
    }
    function newOne(){
        var value=$('#siteId').val();
        $('#editForm').form('clear');
        $('#siteId').val(value);
        $("#parentId").selectpicker('val', '');
        $("#type").selectpicker('val', '普通类');
        $("#attachmentLimit").selectpicker('val', '');
        $('#allowAnonymously').click();
    }
    function deleteOne(id){

    }
    function editOne(index,id){
        $('#editForm').form('clear');
        var data=$('#table').bootstrapTable('getData');
        $('#editForm').form('load',data[index]);
    }

    function showOne(index,id){
        editOne(index,id);
    }
    function importExcel(){
        $('#excelForm').form('submit', {
            url:'${request.contextPath}/declare/importExcel',
            success: function(data){
                var data = eval('(' + data + ')'); // change the JSON string to javascript object
                $('#importModal').modal('hide');
                if (data.result){
                    $('#alertSucess').removeClass('hide');
                    setTimeout(function(){
                        $('#alertSucess').addClass('hide');
                    }, 2000);
                    $('#table').bootstrapTable('refresh',[]);
                }else{
                    $('#alertFault').removeClass('hide');
                }
            }
        });
    }
    $(function(){
        $('#editForm').form({
            success: function(data){
                var data = eval('(' + data + ')'); // change the JSON string to javascript object
                if (data.result){
                    $('#alertSucess').removeClass('hide');
                    setTimeout(function(){
                        $('#alertSucess').addClass('hide');
                    }, 2000);
                    $('#box-edit').closest('.box').toggleClass('active');
                    $('#box-list').closest('.box').addClass('active');
                    $('#table').bootstrapTable('refresh',[]);
                    //window.location.href="list?"+Math.random();
                }else{
                    $("#faultMessage").html(data.message);
                    $('#alertFault').removeClass('hide');
                }
            }
        });
        $('#table').bootstrapTable({});
    });
<g:if test="${!params.layout}">
    </script>
</g:if>
