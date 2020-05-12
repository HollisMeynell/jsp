<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<form method="post" action="" id="listform">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href=""
                                                                               style="float:right; display:none;">添加字段</a>
        </div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li>
                    <input type="text" placeholder="请输入用户名" name="keywords" class="input"
                           style="width:250px; line-height:17px;display:inline-block"/>
                    <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch(1)"> 搜索</a>
                </li>
            </ul>
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th width="100" style="text-align:left; padding-left:20px;">ID</th>
                <th>用户名称</th>
                <th width="10%">更新时间</th>
                <th width="310">操作</th>
            </tr>
            <tr id="voend">
                <td colspan="8">
                    <div class="pagelist"><a onclick="befo()">上一页</a><a id="next" onclick="next()">下一页</a><a onclick="end()">尾页</a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</form>
<script type="text/javascript">
    //搜索
    function changesearch(page) {
        $('.usernode').remove();
        $.ajax({
            type: 'post',
            url: '../userservlet',
            data:{
                'operate':'queryall',
                'name':$("input[name=\'keywords\']").val(),
                'page':page
            },
            success: function (data) {
                data = JSON.parse(data);
                var ed = $('#voend');
                for (var i in data.user) {
                    var dom = '<tr class="usernode id' + data.user[i].id + '">' +
                        data.user[i].id + '<td style="text-align:left; padding-left:20px;"><input type="checkbox" name="id[]" value="" /></td>' +
                        '<td>' + data.user[i].name + '</td>' +
                        '<td>2020-05-02 </td>' +
                        '<td><div class="button-group"> <a class="button border-main" href="setuser.jsp?name=' + data.user[i].name + '&id=' + data.user[i].id + '"><span class="icon-edit"></span> 修改</a> <a class="button border-red" href="javascript:void(0)" onclick="return del(' + data.user[i].id + ')"><span class="icon-trash-o"></span> 删除</a> </div></td>' +
                        '</tr>';
                    ed.before(dom);

                }
                $(".pagelist span").remove()
                var dom = "";
                for (var i = 1;i <= parseInt(data.page);i++){
                    if(i == parseInt(data.this)){
                        dom = dom+'<span class="current">'+i+'</span>'
                    }else{
                        dom = dom+'<span>'+i+'</span>'
                    }
                }
                $('#next').before(dom)
            },
            error: function () {
                alert("error");
            }
        })
    }
    function befo() {
        var p = $(".current").text();
        if(p > 1){
            changesearch(parseInt(p)-1);
        }
    }
    function next() {
        var p = $(".current").text();
        var n = $(".pagelist span").length;
        if(p < n){
            changesearch(parseInt(p)+1);
        }
    }
    function end() {
        var n = $(".pagelist span").length;
        changesearch(n);
    }
    //单个删除
    function del(id) {
        if (confirm("您确定要删除吗?")) {
            $('.id' + id).remove();
            $.ajax({
                type: 'post',
                url: '../userservlet?operate=deleuser&id=' + id,
                success: function (data) {
                    alert(data);
                },
                error: function () {
                    alert("error");
                }
            })
        }
    }

</script>
</body>
</html>
