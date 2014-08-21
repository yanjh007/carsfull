<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Project A</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/signin.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/jquery.sha1.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script>
      $(document).ready(function(){
        $("#login").click(function(){
           var usename  = $("#username").val();
           var password = $("#password").val();

           //checking for blank fields
           if( username =='' || password =='') {
              alert("请输入用户名和密码!!");
           }  else {
              var hash = $.sha1(password); 
              $("#hash").val(hash.concat(username.value));
              $("#password").val('password');
              $("#form_login").submit();
           }
         });

      });
    </script>


  </head>
  <body>
    <div class="container">
      <form class="form-signin" role="form" method="post" id="form_login">
        <?php echo validation_errors(); ?>

        <h2 class="form-signin-heading">系统登录</h2>
        <input type="username" name="username" id="username" class="form-control" placeholder="用户名" required="" autofocus="">
        <br>
        <input type="password" name="password" id="password" class="form-control" placeholder="密码"   required="">
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住登录
          </label>
        </div>

        <input type="hidden" name="hash" id="hash" value="" />
        <button class="btn btn-lg btn-primary btn-block" type="button" name="login" id="login"  value="login">登 录</button>
      </form>
        
    </div>

  </body>
</html>
