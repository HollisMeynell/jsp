<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="true" %>
<%
    String name = request.getParameter("name");
    String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script>
        function chick() {
            var pd = $("input[name='password']").val();
            var rpd = $("input[name='repassword']").val();
            if(pd == rpd){
                $.ajax({
                    type:'post',
                    url: '../userservlet',
                    data:{
                        'operate':'setuser',
                        'name':$("input[name='username']").val(),
                        'ypwd':$("input[name='yuanpassword']").val(),
                        'pwd':$("input[name='password']").val(),
                        'id':'<%=id%>'
                    },
                    success:function (data) {
                        $("input").val('');
                        alert(data);
                    }
                })
                return false;
            }else alert("两次密码不一致,请重新输入");
            $("input[name='password']").val('');
            $("input[name='repassword']").val('');
            return false;
        }
    </script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>修改用户</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="../userservlet" onsubmit="return chick()">
            <div class="form-group">
                <div class="label">
                    <label>用户名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" value="<%=name%>" name="username"/>
                    <div class="tips"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>原密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="yuanpassword" value="" data-validate="member:密码只能为数字"  />
                    <div class="tips"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="password" value="" data-validate="member:密码只能为数字"  />
                    <div class="tips"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>确认密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="repassword" value="" data-validate="member:只能为数字"  />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <input name="operate" value="setuser" hidden>
<%--                <input name="id" value="<%=id%>" hidden>--%>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>
