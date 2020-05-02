<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>登录</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        .noselect {
            height:43px;
            width: 100px;
            font-size: large;
            line-height: 43px;
            cursor:pointer;
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
    </style>
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="bg"></div>
<div class="container">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:150px;"></div>
            <div class="media media-y margin-big-bottom">           
            </div>  
            <%
	Cookie[] cookies=request.getCookies();
	String username="";
	String password="";
	if(cookies!=null){
		for(Cookie cookie:cookies){
		if("username".equals(cookie.getName())){
			username=cookie.getValue();
		}
		if("password".equals(cookie.getName())){
			password=cookie.getValue();
		}
		}
	}
	if (session.getAttribute("username")!=null){
	    session.setAttribute("username",null);
    }
 %>       
            <form action="..\userservlet" method="post" onsubmit="return check()">
            <div class="panel loginbox">
                <div class="text-center margin-big padding-big-top"><h1>后台管理中心</h1></div>
                <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input input-big" name="username" value="<%=username%>" placeholder="登录账号" data-validate="required:请填写账号" />
                            <span class="icon icon-user margin-small"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="password" class="input input-big" name="password" value="<%=password%>" placeholder="登录密码" data-validate="required:请填写密码" />
                            <span class="icon icon-key margin-small"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field">
                            <input type="text" class="input input-big" name="code" placeholder="填写右侧的验证码" data-validate="requ   ired:请填写右侧的验证码" />
<%--                           <img src="images/passcode.jpg" alt="" width="100" height="32" class="passcode" style="height:43px;cursor:pointer;" onclick="this.src=this.src+'?'">--%>
                            <div id="check-code">
                                <div class="code noselect passcode" id="data_code"></div>
                            </div>
                                                   
                        </div>
                    </div>
                </div>
                <input name="operate" value="login" hidden>
                <div style="padding:30px;"><input type="submit" class="button button-block bg-main text-big input-big" value="登录"></div>
            </div>
            </form>          
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    /**
     * 验证码
     * @param {Object} o 验证码长度
     */
    $.fn.code_Obj = function(o) {
        var _this = $(this);
        var options = {
            code_l: o.codeLength,//验证码长度
            codeChars: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
            ],
            codeColors: ['#f44336', '#009688', '#cddc39', '#03a9f4', '#9c27b0', '#5e4444', '#9ebf9f', '#ffc8c4', '#2b4754', '#b4ced9', '#835f53', '#aa677e'],
            code_Init: function() {
                var code = "";
                var codeColor = "";
                var checkCode = _this.find("#data_code");
                for(var i = 0; i < this.code_l; i++) {
                    var charNum = Math.floor(Math.random() * 52);
                    code += this.codeChars[charNum];
                }
                for(var i = 0; i < this.codeColors.length; i++) {
                    var charNum = Math.floor(Math.random() * 12);
                    codeColor = this.codeColors[charNum];
                }
                console.log(code);
                if(checkCode) {
                    checkCode.css('color', codeColor);
                    checkCode.className = "code";
                    checkCode.text(code);
                    checkCode.attr('data-value', code);
                }
            }
        };
        options.code_Init();//初始化验证码
        _this.find("#data_code").bind('click', function() {
            options.code_Init();
        });
    };
    /**
     * 验证码
     * codeLength:验证码长度
     */
    $('#check-code').code_Obj({
        codeLength: 5
    });
    function check() {
        var ma = $("#data_code");
        var s = $("input[name='code']").val().toUpperCase();
        if(ma.html().toUpperCase() == s){
            return true;
        }
        $("input[name='code']").attr({'placeholder':'验证码错误请重新填写'})
        $("input[name='code']").val('');
        ma.click();
        return false;
    }
</script>
</html>