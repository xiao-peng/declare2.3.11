function graphTrace(options) {
    var _defaults = {
        srcEle: this,
        pid: $(this).attr('pid')
    };
    var opts = $.extend(true, _defaults, options);
    // 获取图片资源
    var imageUrl = ctx + "/project/process_instance?pid=" + opts.pid + "&type=image";
    $.getJSON(ctx + '/project/trace?pid=' + opts.pid, function(infos) {

        var positionHtml = "";

        // 生成图片
        var varsArray = new Array();
        $.each(infos, function(i, v) {
            var $positionDiv = $('<div/>', {
                'class': 'activity-attr'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
               // width: (v.width - 2),
                width: (v.width),
              //  height: (v.height - 2),
                height: (v.height),
                backgroundColor: 'black',
                opacity: 0,
                zIndex: $.fn.qtip.zindex - 1
            });

            // 节点边框
            var $border = $('<div/>', {
                'class': 'activity-attr-border'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
               // width: (v.width - 4),
                width: (v.width),
               // height: (v.height - 3),
                height: (v.height),
                zIndex: $.fn.qtip.zindex - 2
            });

            if (v.currentActiviti) {
                $border.addClass('ui-corner-all-12').css({
                    border: '3px solid red'
                });
            }
            positionHtml += $positionDiv.outerHTML() + $border.outerHTML();
            varsArray[varsArray.length] = v.vars;
        });

        $('#workflowTraceDialog img').attr('src', imageUrl);
        $('#workflowTraceDialog #processImageBorder').html(positionHtml);      
 			/*	$('.activity-attr').qtip({
	          content: function() {
	              var vars = $(this).data('vars');
	              var tipContent = "<table class='need-border'>";
	              $.each(vars, function(varKey, varValue) {
	                  if (varValue) {
	                      tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
	                  }
	              });
	              tipContent += "</table>";
	              return tipContent;
	          },
	          show: {
	              event: 'click', // Show it on click...
	              solo: true, // ...and hide all other tooltips...
	              modal: true // ...and make it modal
	          },
	          hide: false,
	          position: {
	              at: 'bottom left',
	              adjust: {
	                  x: 3
	              }
	          }
	      }); */
	     $("#modal_image").modal("show");

        /*
        if ($('#workflowTraceDialog').length == 0) {
            $('<div/>', {
                id: 'workflowTraceDialog',
                title: '查看流程（按ESC键可以关闭）',
                html: "<div><img src='" + imageUrl + "' style='position:absolute; left:0px; top:0px;' />" +
                "<div id='processImageBorder'>" +
                positionHtml +
                "</div>" +
                "</div>"
            }).appendTo('body');
        } else {
            $('#workflowTraceDialog img').attr('src', imageUrl);
            $('#workflowTraceDialog #processImageBorder').html(positionHtml);
        }

        // 设置每个节点的data
        $('#workflowTraceDialog .activity-attr').each(function(i, v) {
            $(this).data('vars', varsArray[i]);
        });


        // 打开对话框
        $('#workflowTraceDialog').dialog({
            modal: true,
            resizable: false,
            dragable: false,
            open: function() {
                $('#workflowTraceDialog').css('padding', '0.2em');
              //  $('#workflowTraceDialog .ui-accordion-content').css('padding', '0.2em').height($('#workflowTraceDialog').height() - 75);

                // 此处用于显示每个节点的信息，如果不需要可以删除
                 $('.activity-attr').qtip({
                    content: function() {
                        var vars = $(this).data('vars');
                        var tipContent = "<table class='need-border'>";
                        $.each(vars, function(varKey, varValue) {
                            if (varValue) {
                                tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
                            }
                        });
                        tipContent += "</table>";
                        return tipContent;
                    },
                    show: {
                        event: 'click', // Show it on click...
                        solo: true, // ...and hide all other tooltips...
                        modal: true // ...and make it modal
                    },
                    hide: false,
                    position: {
                        at: 'bottom left',
                        adjust: {
                            x: 3
                        }
                    }
                });
                // end qtip
            },
            top:10,
            width: document.documentElement.clientWidth * 0.95,
            height: document.documentElement.clientHeight *1.3
        });*/

    });

}

function graphTraceBy(obj,index) {
    var opts = new Object();
    opts.pid = $(obj).attr('pid');
    // 获取图片资源
    var imageUrl = ctx + "/project/process_instance?pid=" + opts.pid + "&type=image";
    $.getJSON(ctx + '/project/trace?pid=' + opts.pid, function(infos) {

        var positionHtml = "";

        // 生成图片
        var varsArray = new Array();
        $.each(infos, function(i, v) {
            var $positionDiv = $('<div/>', {
                'class': 'activity-attr'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
                // width: (v.width - 2),
                width: (v.width),
                //  height: (v.height - 2),
                height: (v.height),
                backgroundColor: 'black',
                opacity: 0,
                zIndex: 2
            });

            // 节点边框
            var $border = $('<div/>', {
                'class': 'activity-attr-border'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
                // width: (v.width - 4),
                width: (v.width),
                // height: (v.height - 3),
                height: (v.height),
                zIndex: 1
            });

            if (v.currentActiviti) {
                $border.addClass('ui-corner-all-12').css({
                    border: '3px solid red'
                });
            }
            positionHtml += $positionDiv.outerHTML() + $border.outerHTML();
            varsArray[varsArray.length] = v.vars;


        });

        $('#workflowTraceDialog img').attr('src', imageUrl);
        $('#workflowTraceDialog #processImageBorder').html(positionHtml);

        // 设置每个节点的data
        $('#workflowTraceDialog .activity-attr').each(function(i, v) {
            $(this).data('vars', varsArray[i]);
        });
        var options={
            animation:true,
            trigger:'hover', //触发tooltip的事件
            title:'流程节点',
            html:true,
            content:function() {
                var vars = $(this).data('vars');
                var tipContent = "<table class='need-border'>";
                $.each(vars, function(varKey, varValue) {
                    if (varValue) {
                        tipContent += "<tr><td>" + varKey + "：</td><td>" + varValue + "<td/></tr>";
                    }
                });
                tipContent += "</table>";
                return tipContent;
            }
        }


        $('#workflowTraceDialog .activity-attr').popover(options);


/*        $('.activity-attr').qtip({
            content: function() {
                var vars = $(this).data('vars');
                var tipContent = "<table class='need-border'>";
                $.each(vars, function(varKey, varValue) {
                    if (varValue) {
                        tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
                    }
                });
                tipContent += "</table>";
                return tipContent;
            },
            show: {
                event: 'click', // Show it on click...
                solo: true, // ...and hide all other tooltips...
                modal: true // ...and make it modal
            },
            hide: false,
            position: {
                at: 'bottom left',
                adjust: {
                    x: 3
                }
            }
        });*/
        /**
         * 获取流程图的大小，为dialog重新赋值图片的大小
         * @type {Image}
         */
        var img=new Image();
        img.src=$('#workflowTraceDialog img').attr('src');
        img.onload=function(){
            var width=img.width,height=img.height+100;
            $("#modal_image .modal-dialog").css('width',width+"px");
            $("#modal_image .modal-content").css('width',width+"px");
            $("#modal_image .modal-dialog").css('height',height+"px");
            $("#modal_image .modal-content").css('height',height+"px");
            $("#modal_image").modal("show");
        };

        /*
         if ($('#workflowTraceDialog').length == 0) {
         $('<div/>', {
         id: 'workflowTraceDialog',
         title: '查看流程（按ESC键可以关闭）',
         html: "<div><img src='" + imageUrl + "' style='position:absolute; left:0px; top:0px;' />" +
         "<div id='processImageBorder'>" +
         positionHtml +
         "</div>" +
         "</div>"
         }).appendTo('body');
         } else {
         $('#workflowTraceDialog img').attr('src', imageUrl);
         $('#workflowTraceDialog #processImageBorder').html(positionHtml);
         }

         // 设置每个节点的data
         $('#workflowTraceDialog .activity-attr').each(function(i, v) {
         $(this).data('vars', varsArray[i]);
         });


         // 打开对话框
         $('#workflowTraceDialog').dialog({
         modal: true,
         resizable: false,
         dragable: false,
         open: function() {
         $('#workflowTraceDialog').css('padding', '0.2em');
         //  $('#workflowTraceDialog .ui-accordion-content').css('padding', '0.2em').height($('#workflowTraceDialog').height() - 75);

         // 此处用于显示每个节点的信息，如果不需要可以删除
         $('.activity-attr').qtip({
         content: function() {
         var vars = $(this).data('vars');
         var tipContent = "<table class='need-border'>";
         $.each(vars, function(varKey, varValue) {
         if (varValue) {
         tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
         }
         });
         tipContent += "</table>";
         return tipContent;
         },
         show: {
         event: 'click', // Show it on click...
         solo: true, // ...and hide all other tooltips...
         modal: true // ...and make it modal
         },
         hide: false,
         position: {
         at: 'bottom left',
         adjust: {
         x: 3
         }
         }
         });
         // end qtip
         },
         top:10,
         width: document.documentElement.clientWidth * 0.95,
         height: document.documentElement.clientHeight *1.3
         });*/

    });

}
