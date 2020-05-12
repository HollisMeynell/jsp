<%@ page import="com.huang.Dao.UserDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

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
    <script>
        var f = false;
        function chick() {
            var pd = $("input[name='password']").val();
            var rpd = $("input[name='repassword']").val();
            var name = $("input[name='username']").val().trim();
            if(name == ''){
                alert("name不可为空");
                return false;
            }else if (pd == rpd) {
                return puth(name);
            } else alert("两次密码不一致,请重新输入");
            $("input[name='password']").val('');
            $("input[name='repassword']").val('');
            return false;
        }
        function puth(name) {

            $.ajax({
                type : 'post',
                url: '../userservlet?operate=isuser&name='+name,
                success:function (data) {
                    if (data == "true"){
                        f = true;
                    }else {
                        f = false;
                        alert("用户名重复")
                    }
                }
            });
            return f;
        }
    </script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>增加用户</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="../userservlet" onsubmit="return chick()">
            <div class="form-group">
                <div class="label">
                    <label>用户名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" value="" name="username" data-validate="required:请输入用户名"/>
                    <div class="tips"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="password" value="" data-validate="member:密码只能为数字"/>
                    <div class="tips"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>确认密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="repassword" value="" data-validate="member:只能为数字"/>
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <input name="operate" value="adduser" hidden>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>